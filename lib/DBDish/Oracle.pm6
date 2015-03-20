# DBDish::Oracle.pm6

use NativeCall;
use DBDish;     # roles for drivers

my constant lib = 'libclntsh';

#module DBDish:auth<mberends>:ver<0.0.1>;

#------------ Oracle library to NativeCall data type mapping ------------

constant sb2            = int16;
constant sb4            = int32;
constant size_t         = long;
constant sword          = int32;
constant ub2            = int16;
constant ub4            = int32;

constant OCIBind        = OpaquePointer;
constant OCIEnv         = OpaquePointer;
constant OCIError       = OpaquePointer;
constant OCISnapshot    = OpaquePointer;
constant OCIStmt        = OpaquePointer;
constant OCISvcCtx      = OpaquePointer;
constant OraText        = Str;

#------------ Oracle library functions in alphabetical order ------------

#sub OCIEnvCreate (
#        CArray[OpaquePointer] $envhpp,
#        int32         $mode,
#        OpaquePointer $ctxp,
#        OpaquePointer $malocfp,
#        OpaquePointer $ralocfp,
#        OpaquePointer $mfreefp,
#        size_t        $xtramemsz,
#        CArray[OpaquePointer] $usrmempp,
#    )
#    returns int
#    is native(lib)
#    { ... }

sub OCIEnvNlsCreate (
        CArray[OCIEnv] $envhpp,
        ub4            $mode,
        OpaquePointer  $ctxp,
        OpaquePointer  $malocfp,
        OpaquePointer  $ralocfp,
        OpaquePointer  $mfreefp,
        size_t         $xtramemsz,
        CArray[OpaquePointer] $usrmempp,
        ub2            $charset,
        ub2            $ncharset,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIErrorGet (
        OpaquePointer $hndlp,
        ub4           $recordno,
        OraText       $sqlstate,
        CArray[sb4]   $errcodep,
        CArray[int8]  $bufp,
        ub4           $bufsiz,
        ub4           $type,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIHandleAlloc (
        OpaquePointer           $parenth,
        CArray[OpaquePointer]   $hndlpp,
        ub4                     $type,
        size_t                  $xtramem_sz,
        CArray[OpaquePointer]   $usrmempp,
    )
    returns sword
    is native(lib)
    { ... }

sub OCILogon2 (
        OCIEnv              $envhp,
        OCIError            $errhp,
        CArray[OCISvcCtx]   $svchp,
        OraText             $username is encoded('utf8'),
        ub4                 $uname_len,
        OraText             $password is encoded('utf8'),
        ub4                 $passwd_len,
        OraText             $dbname is encoded('utf8'),
        ub4                 $dbname_len,
        ub4                 $mode,
    )
    returns sword
    is native(lib)
    { ... }

sub OCILogoff (
        OCISvcCtx   $svchp,
        OCIError    $errhp,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIStmtPrepare2 (
        OCISvcCtx           $svchp,
        CArray[OCIStmt]     $stmthp,
        OCIError            $errhp,
        OraText             $stmttext is encoded('utf8'),
        ub4                 $stmt_len,
        OraText             $key is encoded('utf8'),
        ub4                 $keylen,
        ub4                 $language,
        ub4                 $mode,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIAttrGet (
        OpaquePointer   $trgthndlp,
        ub4             $trghndltyp,
        CArray[int8]    $attributep,
        ub4             $sizep,
        ub4             $attrtype,
        OCIError        $errhp,
    )
    returns sword
    is native(lib)
    { ... }

# strings
sub OCIBindByName_Str (
        OCIStmt             $stmtp,
        CArray[OCIBind]     $bindpp,
        #CArray              $bindpp,
        #OCIBind             $bindpp is rw,
        OCIError            $errhp,
        OraText             $placeholder is encoded('utf8'),
        sb4                 $placeh_len,
        Str                 $valuep is encoded('utf8'),
        sb4                 $value_sz,
        ub2                 $dty,
        sb2                 $indp is rw,
        ub2                 $alenp is rw,
        ub2                 $rcodep is rw,
        ub4                 $maxarr_len,
        ub4                 $curelep is rw,
        ub4                 $mode,
    )
    returns sword
    is native(lib)
    is symbol('OCIBindByName')
    { ... }

# ints
sub OCIBindByName_Int (
        OCIStmt             $stmtp,
        CArray[OCIBind]     $bindpp,
        #CArray              $bindpp,
        #OCIBind             $bindpp is rw,
        OCIError            $errhp,
        OraText             $placeholder is encoded('utf8'),
        sb4                 $placeh_len,
        long                $valuep is rw,
        sb4                 $value_sz,
        ub2                 $dty,
        sb2                 $indp is rw,
        ub2                 $alenp is rw,
        ub2                 $rcodep is rw,
        ub4                 $maxarr_len,
        ub4                 $curelep is rw,
        ub4                 $mode,
    )
    returns sword
    is native(lib)
    is symbol('OCIBindByName')
    { ... }

# floats
sub OCIBindByName_Real (
        OCIStmt             $stmtp,
        CArray[OCIBind]     $bindpp,
        #CArray              $bindpp,
        #OCIBind             $bindpp is rw,
        OCIError            $errhp,
        OraText             $placeholder is encoded('utf8'),
        sb4                 $placeh_len,
        #CArray[int8]    $valuep,
        num64               $valuep is rw,
        sb4                 $value_sz,
        ub2                 $dty,
        sb2                 $indp is rw,
        ub2                 $alenp is rw,
        ub2                 $rcodep is rw,
        ub4                 $maxarr_len,
        ub4                 $curelep is rw,
        ub4                 $mode,
    )
    returns sword
    is native(lib)
    is symbol('OCIBindByName')
    { ... }

sub OCIStmtExecute (
        OCISvcCtx       $svchp,
        OCIStmt         $stmtp,
        OCIError        $errhp,
        ub4             $iters,
        ub4             $rowoff,
        OCISnapshot     $snap_in,
        OCISnapshot     $snap_out,
        ub4             $mode,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIParamGet (
        OpaquePointer           $hndlp,
        ub4                     $htype,
        OCIError                $errhp,
        CArray[OpaquePointer]   $parmdpp,
        ub4                     $pos,
    )
    returns sword
    is native(lib)
    { ... }

sub OCIStmtFetch2 (
        OCIStmt     $stmtp,
        OCIError    $errhp,
        ub4         $nrows,
        ub2         $orientation,
        sb4         $fetchOffset,
        ub4         $mode,
    )
    returns sword
    is native(lib)
    { ... }

#-----

my ub4 constant OCI_DEFAULT     = 0;
constant OCI_THREADED           = 1;

constant OCI_SUCCESS            = 0;
constant OCI_ERROR              = -1;

constant OCI_HTYPE_ENV          = 1;
constant OCI_HTYPE_ERROR        = 2;
constant OCI_HTYPE_STMT         = 4;

constant OCI_LOGON2_STMTCACHE   = 4;

constant OCI_NTV_SYNTAX         = 1;

constant OCI_ATTR_STMT_TYPE     = 24;

constant OCI_STMT_UNKNOWN       = 0;
constant OCI_STMT_SELECT        = 1;
constant OCI_STMT_UPDATE        = 2;
constant OCI_STMT_DELETE        = 3;
constant OCI_STMT_INSERT        = 4;
constant OCI_STMT_CREATE        = 5;
constant OCI_STMT_DROP          = 6;
constant OCI_STMT_ALTER         = 7;
constant OCI_STMT_BEGIN         = 8;
constant OCI_STMT_DECLARE       = 9;
constant OCI_STMT_CALL          = 10;

constant SQLT_CHR               = 1;
constant SQLT_INT               = 3;
constant SQLT_FLT               = 4;
constant SQLT_STR               = 5;

# SELECT NLS_CHARSET_ID('AL32UTF8') FROM dual;
constant AL32UTF8               = 873;

sub get_errortext(OCIError $handle, $handle_type = OCI_HTYPE_ERROR) {
    my @errorcodep := CArray[sb4].new;
    @errorcodep[0] = 0;
    my @errortextp := CArray[int8].new;
    @errortextp[$_] = 0
        for ^512;

    OCIErrorGet( $handle, 1, OraText, @errorcodep, @errortextp, 512, $handle_type );
    my @errortextary;
    @errortextary[$_] = @errortextp[$_]
        for ^512;
    return Buf.new(@errortextary).decode();
}

#sub status-is-ok($status) { $status ~~ 0..4 }

#-----------------------------------------------------------------------

my grammar OracleTokenizer {
    token TOP {
        ^
        (
            | <normal>
            | <placeholder>
            | <single_quote>
            | <double_quote>
        )*
        $
    }
    token normal { <-[?"']>+ }
    token placeholder { '?' }
    token double_quote_normal { <-[\\"]>+ }
    token double_quote_escape { [\\ . ]+ }
    token double_quote {
        \"
        [
            | <.double_quote_normal>
            | <.double_quote_escape>
        ]*
        \"
    }
    token single_quote_normal { <-['\\]>+ }
    token single_quote_escape { [ \'\' || \\ . ]+ }
    token single_quote {
        \'
        [
            | <.single_quote_normal>
            | <.single_quote_escape>
        ]*
        \'
    }
}

my class OracleTokenizer::Actions {
    has $.counter = 0;
    method TOP($/) {
        make $0.map({.values[0].ast}).join;
    }
    method normal($/)       { make $/.Str }
    # replace each ? placeholder with a named one
    method placeholder($/)  { make ':p' ~ $!counter++ }
    method single_quote($/) { make $/.Str }
    method double_quote($/) { make $/.Str }
}


class DBDish::Oracle::StatementHandle does DBDish::StatementHandle {
    has $!statement;
    has $!statementtype;
    has $!svchp;
    has $!errhp;
    has $!stmthp;
#    has $!param_count;
    has $.dbh;
    has $!result;
#    has $!affected_rows;
#    has @!column_names;
#    has Int $!row_count;
#    has $!field_count;
#    has $!current_row = 0;
#
#    method !handle-errors {
#        my $status = PQresultStatus($!result);
#        if status-is-ok($status) {
#            self!reset_errstr;
#            return True;
#        }
#        else {
#            self!set_errstr(PQresultErrorMessage($!result));
#            die self.errstr if $.RaiseError;
#            return Nil;
#        }
#    }
#
#    method !munge_statement {
#        my $count = 0;
#        $!statement.subst(:g, '?', { '$' ~ ++$count});
#    }
#
    submethod BUILD(:$!statement!, :$!statementtype!, :$!svchp!, :$!errhp!, :$!stmthp!, :$!dbh!) { }

    method execute(*@params is copy) {
#        $!current_row = 0;
#        die "Wrong number of arguments to method execute: got @params.elems(), expected $!param_count" if @params != $!param_count;

        # bind placeholder values
        for @params.kv -> $k, $v {
            my @bindpp := CArray[OCIBind].new;
            @bindpp[0]  = OCIBind;
            #my OCIBind $bindpp;

            my OraText $placeholder = ":p$k";
            my sb4 $placeh_len = $placeholder.encode('utf8').bytes;

            my $valuebuf;
            my sb4 $value_sz;
            my ub2 $dty;
            my $method;
            if $v ~~ Int {
                $dty = SQLT_INT;
                $valuebuf = $v;
                # see multi sub defition for the C data type
                $value_sz = nativesizeof(long);
                $method = &OCIBindByName_Int;
            }
            elsif $v ~~ Real {
                $dty = SQLT_FLT;
                $valuebuf = $v.Num;
                # see multi sub defition for the C data type
                $value_sz = nativesizeof(num64);
                $method = &OCIBindByName_Real;
            }
            elsif $v ~~ Str {
                $dty = SQLT_CHR;
                $valuebuf = $v;
                $value_sz = $v.encode('utf8').bytes;
                $method = &OCIBindByName_Str;
            }
            else {
                die "unhandled type: $v";
            }
            # -1 tells OCI to set the value to NULL
            my sb2 $indp = $v.chars == 0 ?? -1 !! 0;
            my ub2 $alenp = 0;
            my ub2 $rcodep = 0;
            my ub4 $maxarr_len = 0;
            my ub4 $curelep = 0;
            warn "binding '$placeholder' ($placeh_len): '$v' ($value_sz) as OCI type '$dty' Perl type '$v.^name()' \n";
            my $errcode = $method(
                $!stmthp,
                @bindpp,
                $!errhp,
                $placeholder,
                $placeh_len,
                $valuebuf,
                $value_sz,
                $dty,
                $indp,
                $alenp,
                $rcodep,
                $maxarr_len,
                $curelep,
                OCI_DEFAULT,
            );
            if $errcode ne OCI_SUCCESS {
                my $errortext = get_errortext($!errhp);
                die "bind of param '$placeholder' with value '$v' of statement '$!statement' failed ($errcode): '$errortext'";
            }
            #warn "bind of param '$placeholder' with value '$valuebuf' succeeded";
        }

        my $iters = $!statementtype eq OCI_STMT_SELECT ?? 0 !! 1;

        my $errcode = OCIStmtExecute(
            $!svchp,
            $!stmthp,
            $!errhp,
            $iters,
            0,
            OpaquePointer,
            OpaquePointer,
            OCI_DEFAULT,
        );
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($!errhp);
            die "execute of '$!statement' failed ($errcode): '$errortext'";
        }
        #say 'successfully executed';

        # for DDL statements, no further steps are necessary
        return "0E0"
            if $!statementtype ~~ OCI_STMT_CREATE, OCI_STMT_DROP, OCI_STMT_ALTER;

        my @parmdpp := CArray[OpaquePointer].new;
        @parmdpp[0]  = OpaquePointer;
        $errcode = OCIParamGet($!stmthp, OCI_HTYPE_STMT, $!errhp, @parmdpp, 1);
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($!errhp);
            die "param get failed ($errcode): '$errortext'";
        }

        $errcode = OCIStmtFetch2($!stmthp, $!errhp, 1, OCI_DEFAULT, 0, OCI_DEFAULT);
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($!errhp);
            die "fetch failed ($errcode): '$errortext'";
        }
#
#        $!result = PQexecPrepared($!pg_conn, $!statement_name, @params.elems,
#                @param_values,
#                OpaquePointer, # ParamLengths, NULL pointer == all text
#                OpaquePointer, # ParamFormats, NULL pointer == all text
#                0,             # Resultformat, 0 == text
#        );
#
#        self!handle-errors;
#        $!row_count = PQntuples($!result);
#
#        my $rows = self.rows;
#        return ($rows == 0) ?? "0E0" !! $rows;
    }

#    # do() and execute() return the number of affected rows directly or:
#    # rows() is called on the statement handle $sth.
#    method rows() {
#        unless defined $!affected_rows {
#            $!affected_rows = PQcmdTuples($!result);
#
#            self!handle-errors;
#        }
#
#        if defined $!affected_rows {
#            return +$!affected_rows;
#        }
#    }

    method fetchrow() {
#        my @row_array;
#        return if $!current_row >= $!row_count;
#
#        unless defined $!field_count {
#            $!field_count = PQnfields($!result);
#        }
#
#        if defined $!result {
#            self!reset_errstr;
#
#            for ^$!field_count {
#                @row_array.push(PQgetvalue($!result, $!current_row, $_));
#            }
#            $!current_row++;
#            self!handle-errors;
#
#            if ! @row_array { self.finish; }
#        }
#        return @row_array;
    }

#    method column_names {
#        $!field_count = PQnfields($!result);
#        unless @!column_names {
#            for ^$!field_count {
#                my $column_name = PQfname($!result, $_);
#                @!column_names.push($column_name);
#            }
#        }
#        @!column_names
#    }
#
#    # for debugging only so far
#    method column_oids {
#        $!field_count = PQnfields($!result);
#        my @res;
#        for ^$!field_count {
#            @res.push: PQftype($!result, $_);
#        }
#        @res;
#    }
#
#    method fetchall_hashref(Str $key) {
#        my %results;
#
#        return if $!current_row >= $!row_count;
#
#        while my $row = self.fetchrow_hashref {
#            %results{$row{$key}} = $row;
#        }
#
#        my $results_ref = %results;
#        return $results_ref;
#    }

    method finish() {
        if defined($!result) {
            #PQclear($!result);
            #$!result       = Any;
            #@!column_names = ();
        }
        return Bool::True;
    }

#    method !get_row {
#        my @data;
#        for ^$!field_count {
#            @data.push(PQgetvalue($!result, $!current_row, $_));
#        }
#        $!current_row++;
#
#        return @data;
#    }
}

class DBDish::Oracle::Connection does DBDish::Connection {
    has $!svchp;
    has $!errhp;
    #has $.AutoCommit is rw = 1;
    #has $.in_transaction is rw;
    submethod BUILD(:$!svchp!, :$!errhp!) { }

    method prepare(Str $statement, $attr?) {
        my $oracle_statement = DBDish::Oracle::oracle-replace-placeholder($statement);
        my @stmthpp := CArray[OCIStmt].new;
        @stmthpp[0]  = OCIStmt;
        my $errcode = OCIStmtPrepare2(
                $!svchp,
                @stmthpp,
                $!errhp,
                $oracle_statement,
                $oracle_statement.encode('utf8').bytes,
                OraText,
                0,
                OCI_NTV_SYNTAX,
                OCI_DEFAULT,
            );
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($!errhp);
            die "prepare failed ($errcode): '$errortext'";
#            die self.errstr if $.RaiseError;
#            return Nil;
        }
        my $stmthp = @stmthpp[0];

        my @attributep := CArray[int8].new;
        @attributep[0] = 0;
        $errcode = OCIAttrGet($stmthp, OCI_HTYPE_STMT, @attributep, OpaquePointer, OCI_ATTR_STMT_TYPE, $!errhp);
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($!errhp);
            die "statement type get failed ($errcode): '$errortext'";
        }
        my $statementtype = @attributep[0];

#        my $info = PQdescribePrepared($!pg_conn, $statement_name);
#        my $param_count = PQnparams($info);

        my $statement_handle = DBDish::Oracle::StatementHandle.bless(
            # TODO: pass the original or the Oracle statment here?
            statement => $oracle_statement,
            #:$statement,
            :$statementtype,
            :$!svchp,
            :$!errhp,
            :$stmthp,
            #:$.RaiseError,
            :dbh(self),
        );
        return $statement_handle;
    }
#
#    method do(Str $statement, *@bind is copy) {
#        my $sth = self.prepare($statement);
#        $sth.execute(@bind);
#        my $rows = $sth.rows;
#        return ($rows == 0) ?? "0E0" !! $rows;
#    }
#
#    method selectrow_arrayref(Str $statement, $attr?, *@bind is copy) {
#        my $sth = self.prepare($statement, $attr);
#        $sth.execute(@bind);
#        return $sth.fetchrow_arrayref;
#    }
#
#    method selectrow_hashref(Str $statement, $attr?, *@bind is copy) {
#        my $sth = self.prepare($statement, $attr);
#        $sth.execute(@bind);
#        return $sth.fetchrow_hashref;
#    }
#
#    method selectall_arrayref(Str $statement, $attr?, *@bind is copy) {
#        my $sth = self.prepare($statement, $attr);
#        $sth.execute(@bind);
#        return $sth.fetchall_arrayref;
#    }
#
#    method selectall_hashref(Str $statement, Str $key, $attr?, *@bind is copy) {
#        my $sth = self.prepare($statement, $attr);
#        $sth.execute(@bind);
#        return $sth.fetchall_hashref($key);
#    }
#
#    method selectcol_arrayref(Str $statement, $attr?, *@bind is copy) {
#        my @results;
#
#        my $sth = self.prepare($statement, $attr);
#        $sth.execute(@bind);
#        while (my $row = $sth.fetchrow_arrayref) {
#            @results.push($row[0]);
#        }
#
#        my $aref = @results;
#        return $aref;
#    }
#
#    method commit {
#        if $!AutoCommit {
#            warn "Commit ineffective while AutoCommit is on";
#            return;
#        };
#        PQexec($!pg_conn, "COMMIT");
#        $.in_transaction = 0;
#    }
#
#    method rollback {
#        if $!AutoCommit {
#            warn "Rollback ineffective while AutoCommit is on";
#            return;
#        };
#        PQexec($!pg_conn, "ROLLBACK");
#        $.in_transaction = 0;
#    }
#
#    method ping {
#        PQstatus($!pg_conn) == CONNECTION_OK
#    }

    method disconnect() {
        OCILogoff($!svchp, $!errhp);
        True;
    }
}

class DBDish::Oracle:auth<mberends>:ver<0.0.1> {

    our sub oracle-replace-placeholder(Str $query) is export {
        OracleTokenizer.parse($query, :actions(OracleTokenizer::Actions.new))
            and $/.ast;
    }

    has $.Version = 0.01;
    #has $!errstr;
    #method !errstr() is rw { $!errstr }
    #method errstr() { $!errstr }

    #sub quote-and-escape($s) {
    #    "'" ~ $s.trans([q{'}, q{\\]}] => [q{\\\'}, q{\\\\}])
    #        ~ "'"
    #}

#------------------ methods to be called from DBIish ------------------
    method connect(*%params) {
        # TODO: the dbname from tnsnames.ora includes the host and port config
        #my $host     = %params<host>     // 'localhost';
        #my $port     = %params<port>     // 1521;
        my $database = %params<database> // die 'Missing <database> config';
        my $username = %params<username> // die 'Missing <username> config';
        my $password = %params<password> // die 'Missing <password> config';

        # create the environment handle
        my @envhpp := CArray[OpaquePointer].new;
        @envhpp[0]  = OpaquePointer;
        my OpaquePointer $ctxp,

        my sword $errcode = OCIEnvNlsCreate(
            @envhpp,
            OCI_DEFAULT,
            $ctxp,
            OpaquePointer,
            OpaquePointer,
            OpaquePointer,
            0,
            OpaquePointer,
            AL32UTF8,
            AL32UTF8,
        );

        # fetch environment handle from pointer
        my $envhp = @envhpp[0];

        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext( $envhp, OCI_HTYPE_ENV );
            die "OCIEnvNlsCreate failed: '$errortext'";
        }

        # allocate the error handle
        my @errhpp := CArray[OpaquePointer].new;
        @errhpp[0]  = OpaquePointer;
        $errcode = OCIHandleAlloc($envhp, @errhpp, OCI_HTYPE_ERROR, 0, OpaquePointer );
        if $errcode ne OCI_SUCCESS {
            die "OCIHandleAlloc failed: '$errcode'";
        }
        my $errhp = @errhpp[0];

        my @svchp := CArray[OCISvcCtx].new;
        @svchp[0]  = OCISvcCtx;

        $errcode = OCILogon2(
            $envhp,
            $errhp,
            @svchp,
            $username,
            $username.encode('utf8').bytes,
            $password,
            $password.encode('utf8').bytes,
            $database,
            $database.encode('utf8').bytes,
            OCI_LOGON2_STMTCACHE,
        );
        if $errcode ne OCI_SUCCESS {
            my $errortext = get_errortext($errhp);
            die "OCILogon2 failed: '$errortext'";
        }
        my $svchp = @svchp[0];

        my $connection = DBDish::Oracle::Connection.bless(
                :$svchp,
                :$errhp,
                #:RaiseError(%params<RaiseError>),
            );
        return $connection;
    }
}

=begin pod

=head1 DESCRIPTION
# 'zavolaj' is a Native Call Interface for Rakudo/Parrot. 'DBIish' and
# 'DBDish::Oracle' are Perl 6 modules that use 'zavolaj' to use the
# standard libclntsh library.  There is a long term Parrot based
# project to develop a new, comprehensive DBI architecture for Parrot
# and Perl 6.  DBIish is not that, it is a naive rewrite of the
# similarly named Perl 5 modules.  Hence the 'Mini' part of the name.

=head1 CLASSES
The DBDish::Oracle module contains the same classes and methods as every
database driver.  Therefore read the main documentation of usage in
L<doc:DBIish> and internal architecture in L<doc:DBDish>.  Below are
only notes about code unique to the DBDish::Oracle implementation.

=head1 SEE ALSO
The Oracle OCI Documentation, C Library.
L<http://docs.oracle.com/cd/E11882_01/appdev.112/e10646/oci02bas.htm#LNOCI16208>

=end pod

