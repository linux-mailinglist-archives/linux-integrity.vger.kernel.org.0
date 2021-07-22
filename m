Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB63D2B42
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhGVQz0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:55:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3458 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhGVQzZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:55:25 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzpH6vm4z6H7WK;
        Fri, 23 Jul 2021 01:24:23 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:35:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 7/7] Add tests for EVM portable signatures
Date:   Thu, 22 Jul 2021 19:34:14 +0200
Message-ID: <20210722173414.1738041-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

EVM portable signatures are particularly suitable for the protection of
metadata of immutable files where metadata is signed by a software vendor.
They can be used for example in conjunction with an IMA policy that
appraises only executed and memory mapped files.

However, some usability issues are still unsolved, especially when EVM is
used without loading an HMAC key. The kernel patch set 'evm: Improve
usability of portable signatures' attempts to fix the open issues.

The purpose of the new tests is to verify that operations on files with EVM
portable signatures succeed and that the new kernel patch set does not
break the existing kernel integrity expectations.

To run the tests, it is necessary to pass the path of the kernel private
key with the TST_KEY_PATH environment variable. If not provided, the script
searches the key in /lib/modules/$(uname -r)/source/certs/signing_key.pem
and in the current directory. Root privileges are required to mount the
image, configure IMA/EVM and set xattrs.

The script attempts to launch a UML kernel named 'linux' if it is found in
the ima-evm-utils root directory.

Only the tests with a compatible EVM mode will be executed, unless the
TST_EVM_CHANGE_MODE variable is set to 1 (if the tests are executed by a
UML kernel TST_EVM_CHANGE_MODE is always set to 1). In this case, the
script attempts to change the current EVM mode.

The check_evm_revalidate() test can be executed only if
EVM_ALLOW_METADATA_WRITES is set in advance before running the tests. To do
it, it is sufficient to execute:

echo 4 > /sys/kernel/security/evm

This step is not necessary if the script launches a UML kernel.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 build.sh                       |    1 +
 ci/alpine.sh                   |    5 +-
 ci/debian.sh                   |    6 +-
 ci/fedora.sh                   |    6 +-
 ci/tumbleweed.sh               |    6 +-
 tests/Makefile.am              |    3 +-
 tests/portable_signatures.test | 1157 ++++++++++++++++++++++++++++++++
 7 files changed, 1179 insertions(+), 5 deletions(-)
 create mode 100755 tests/portable_signatures.test

diff --git a/build.sh b/build.sh
index c4d28f1302c6..4f002445a68b 100755
--- a/build.sh
+++ b/build.sh
@@ -90,6 +90,7 @@ if [ $ret -eq 0 ]; then
 		   grep "skipped" tests/sign_verify.log | wc -l
 	fi
 	tail -20 tests/boot_aggregate.log
+	tail -100 tests/portable_signatures.log
 	exit 0
 fi
 
diff --git a/ci/alpine.sh b/ci/alpine.sh
index a074ea0e841c..8cac021fd0de 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -45,7 +45,10 @@ apk add \
 	xxd \
 	curl \
 	haveged \
-	openrc
+	openrc \
+	acl \
+	e2fsprogs \
+	keyutils
 
 if [ ! "$TSS" ]; then
 	apk add git
diff --git a/ci/debian.sh b/ci/debian.sh
index 58004a0bc028..8e86f051d481 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -52,7 +52,11 @@ $apt \
 	curl \
 	ca-certificates \
 	haveged \
-	systemd-sysv
+	systemd-sysv \
+	acl \
+	e2fsprogs \
+	keyutils \
+	libcap2-bin
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 6cc3cb46fb56..cffea38ca690 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -48,7 +48,11 @@ yum -y install \
 	which \
 	curl \
 	haveged \
-	systemd
+	systemd \
+	keyutils \
+	e2fsprogs \
+	acl \
+	libcap
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index a7039129d02f..3b78a1edf501 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -43,7 +43,11 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	xsltproc \
 	curl \
 	haveged \
-	systemd-sysvinit
+	systemd-sysvinit \
+	e2fsprogs \
+	keyutils \
+	acl \
+	libcap-progs
 
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
diff --git a/tests/Makefile.am b/tests/Makefile.am
index ff928e177406..c3f6a151e101 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,7 +1,8 @@
 check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
-check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test
+check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
+		 portable_signatures.test
 
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
new file mode 100755
index 000000000000..cacbf7a9bd14
--- /dev/null
+++ b/tests/portable_signatures.test
@@ -0,0 +1,1157 @@
+#!/bin/bash
+
+#
+# Check if operations on files with EVM portable signatures succeed.
+
+trap cleanup SIGINT SIGTERM SIGSEGV EXIT
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
+
+# From security/integrity/evm/evm.h in kernel source directory.
+let "EVM_INIT_HMAC=0x0001"
+let "EVM_INIT_X509=0x0002"
+let "EVM_ALLOW_METADATA_WRITES=0x0004"
+let "EVM_SETUP_COMPLETE=0x80000000"
+
+cd "$(dirname "$0")"
+export PATH=$PWD/../src:$PATH
+export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
+. ./functions.sh
+_require evmctl
+
+cleanup() {
+	if [ "$loop_mounted" = "1" ]; then
+		popd > /dev/null
+
+		if [ -n "$mountpoint_idmapped" ]; then
+			umount $mountpoint_idmapped
+		fi
+
+		umount $mountpoint
+	fi
+
+	if [ -n "$dev" ]; then
+		losetup -d $dev
+	fi
+
+	rm -f $image
+	rm -f $key_path_der
+	rm -Rf $mountpoint
+
+	if [ -n "$mountpoint_idmapped" ]; then
+		rm -Rf $mountpoint_idmapped
+	fi
+
+	_cleanup_user_mode
+	_report_exit
+}
+
+get_xattr() {
+	format="hex"
+
+	if [ "$1" = "security.selinux" ]; then
+		format="text"
+	fi
+
+	getfattr -n $1 -e $format -d $2 2> /dev/null | awk -F "=" '$1 == "'$1'" {if ("'$format'" == "hex") v=substr($2, 3); else { split($2, temp, "\""); v=temp[2] }; print v}'
+}
+
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26d"
+APPRAISE_DIGSIG_FOWNER=2000
+APPRAISE_DIGSIG_RULE="appraise fsuuid=$IMA_UUID fowner=$APPRAISE_DIGSIG_FOWNER appraise_type=imasig"
+MEASURE_FOWNER=2001
+MEASURE_RULE="measure fsuuid=$IMA_UUID fowner=$MEASURE_FOWNER template=ima-sig"
+APPRAISE_FOWNER=2002
+APPRAISE_RULE="appraise fsuuid=$IMA_UUID fowner=$APPRAISE_FOWNER"
+METADATA_CHANGE_FOWNER=3001
+METADATA_CHANGE_FOWNER_2=3002
+
+check_load_ima_rule() {
+	rule_loaded=$(cat /sys/kernel/security/ima/policy | grep "$1")
+	if [ -z "$rule_loaded" ]; then
+		new_policy=$(mktemp -p $mountpoint)
+		echo $1 > $new_policy
+		evmctl sign -o -a sha256 --imasig --key $key_path $new_policy &> /dev/null
+		echo $new_policy > /sys/kernel/security/ima/policy
+		result=$?
+		rm -f $new_policy
+
+		if [ $result -ne 0 ]; then
+			echo "${RED}Failed to set IMA policy${NORM}"
+			return $FAIL
+		fi
+	fi
+
+	return $OK
+}
+
+# The purpose of this test is to verify that the patch 'ima: Allow imasig
+# requirement to be satisfied by EVM portable signatures' didn't break the
+# current behavior (IMA signatures still satisfy the imasig requirement).
+check_ima_sig_appraisal() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $((evm_value & (EVM_INIT_X509 | EVM_INIT_HMAC))) -ne 0 ]; then
+		echo "${CYAN}EVM mode 0 required${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl ima_sign -a sha256 --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $APPRAISE_DIGSIG_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	check_load_ima_rule "$APPRAISE_DIGSIG_RULE"
+	result=$?
+	if [ $result -ne $OK ]; then
+		return $result
+	fi
+
+	# Check if appraisal works.
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Ensure that files with IMA signature cannot be updated (immutable).
+	echo "test" 2> /dev/null >> test-file
+	if [ $? -eq 0 ]; then
+		echo "${RED}Write to test-file should not succeed (immutable file)${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_ima_sig_appraisal() {
+	rm -f test-file
+}
+
+# Requires:
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is to verify that the patch 'ima: Introduce template
+# field evmsig and write to field sig as fallback' still allows IMA signatures
+# to be displayed in the measurement list.
+check_ima_sig_ima_measurement_list() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl ima_sign -a sha256 --imasig --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $MEASURE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	check_load_ima_rule "$MEASURE_RULE"
+	result=$?
+	if [ $result -ne $OK ]; then
+		return $result
+	fi
+
+	# Read the file to add it to the measurement list.
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return $FAIL
+	fi
+
+	ima_sig_fs=$(get_xattr security.ima test-file)
+	if [ -z "$ima_sig_fs" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return $FAIL
+	fi
+
+	# Search security.ima in the measurement list.
+	ima_sig_list=$(cat /sys/kernel/security/ima/ascii_runtime_measurements | awk '$6 == "'$ima_sig_fs'"')
+	if [ -z "$ima_sig_list" ]; then
+		echo "${RED}security.ima mismatch (xattr != measurement list)${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_ima_sig_ima_measurement_list() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that new files can be created when EVM
+# is initialized only with a public key.
+check_create_file() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	# To trigger the bug we need to enable public key verification without HMAC key loaded.
+	if [ $((evm_value & $EVM_INIT_X509)) -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	if [ $((evm_value & $EVM_INIT_HMAC)) -eq $EVM_INIT_HMAC ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_HMAC must be disabled${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_create_file() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that EVM with the patches above allows
+# metadata to copied one by one, even if the portable signature verification
+# temporarily fails until the copy is completed.
+check_cp_preserve_xattrs() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $evm_value -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl sign -o -a sha256 --imahash --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Check if cp is allowed to set metadata for the new file.
+	cp -a test-file test-file.copy
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot copy test-file with attrs/xattrs preserved${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_cp_preserve_xattrs() {
+	rm -f test-file test-file.copy
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is similar to that of the previous test, with the
+# difference that tar is used instead of cp. One remark is that the owner is
+# intentionally different (or it should be) from the current owner, to
+# incrementally test the patches without 'evm: Allow setxattr() and setattr()
+# for unmodified metadata'.
+check_tar_extract_xattrs_different_owner() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $evm_value -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	mkdir in out
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot create directories${NORM}"
+		return $FAIL
+	fi
+
+	echo "test" > in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown 3000 in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	chmod 600 in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl sign -o -a sha256 --imahash --key $key_path in/test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	tar --xattrs-include=* -cf test-archive.tar in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	# Check if tar is allowed to set metadata for the extracted file.
+	# Ensure that the owner from the archive is different from the
+	# owner of the extracted file to avoid that portable signature
+	# verification succeeds before restoring original metadata
+	# (a patch allows modification of immutable metadata if portable
+	# signature verification fails).
+	tar --xattrs-include=* -xf test-archive.tar -C out
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_tar_extract_xattrs_different_owner() {
+	rm -Rf in out test-archive.tar
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Pass user namespace to set/remove xattr hooks
+# - evm: Allow setxattr() and setattr() for unmodified metadata
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is similar to that of the previous two tests. The
+# difference is that tar is used instead of cp, and the extracted files have
+# the same owner as the current one. Thus, this test requires 'evm: Allow
+# setxattr() and setattr() for unmodified metadata'.
+check_tar_extract_xattrs_same_owner() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $evm_value -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	mkdir in out
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot create directories${NORM}"
+		return $FAIL
+	fi
+
+	echo "test" > in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl sign -o -a sha256 --imahash --key $key_path in/test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	tar --xattrs-include=* -cf test-archive.tar in/test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	# Check if tar is allowed to set metadata for the extracted file.
+	# This test is different from the previous one, as the owner
+	# from the archive is the same of the owner of the extracted
+	# file. tar will attempt anyway to restore the original owner but
+	# unlike the previous test, portable signature verification already
+	# succeeds at the time the owner is set (another patch allows
+	# metadata operations if those operations don't modify current
+	# values).
+	tar --xattrs-include=* -xf test-archive.tar -C out
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_tar_extract_xattrs_same_owner() {
+	rm -Rf in out test-archive.tar
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Pass user namespace to set/remove xattr hooks
+# - evm: Allow setxattr() and setattr() for unmodified metadata
+# - ima: Don't remove security.ima if file must not be appraised
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to further verify the patches above, by executing
+# commands to set the same or different metadata. Setting the same metadata
+# should be allowed, setting different metadata should be denied.
+check_metadata_change() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $evm_value -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $METADATA_CHANGE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	chgrp $METADATA_CHANGE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change group of test-file${NORM}"
+		return $FAIL
+	fi
+
+	chmod 2644 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl sign -o -a sha256 --imahash --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	# If metadata modification is not allowed, EVM should deny any
+	# operation that modifies metadata. Check if setting the same
+	# value is allowed.
+	chown $METADATA_CHANGE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot set same owner for test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Setting a different value should not be allowed.
+	chown $METADATA_CHANGE_FOWNER_2 test-file 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Owner change for test-file should not be allowed (immutable metadata)${NORM}"
+		return $FAIL
+	fi
+
+	# Repeat the test for the file mode.
+	chmod 2644 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot set same mode for test-file${NORM}"
+		return $FAIL
+	fi
+
+	chmod 2666 test-file 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Mode change for test-file should not be allowed (immutable metadata)${NORM}"
+		return $FAIL
+	fi
+
+	if [ -n "$(which chcon 2> /dev/null)" ] && [ -n "$(which getenforce 2> /dev/null)" ] && [ "$(getenforce 2> /dev/null)" != "Disabled" ]; then
+		# Repeat the test for the SELinux label.
+		label=$(get_xattr security.selinux test-file)
+
+		if [ -n "$label" ]; then
+			chcon $label test-file
+			if [ $? -ne 0 ]; then
+				echo "${RED}Cannot set same security.selinux for test-file${NORM}"
+				return $FAIL
+			fi
+		fi
+
+		chcon unconfined_u:object_r:null_device_t:s0 test-file 2> /dev/null
+		if [ $? -eq 0 ]; then
+			echo "${RED}security.selinux change for test file should not be allowed (immutable metadata)${NORM}"
+			return $FAIL
+		fi
+	fi
+
+	# Repeat the test for the IMA signature.
+	ima_xattr=$(get_xattr security.ima test-file)
+	if [ -z "$ima_xattr" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return $FAIL
+	fi
+
+	setfattr -n security.ima -v 0x$ima_xattr test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot set same security.ima for test-file${NORM}"
+		return $FAIL
+	fi
+
+	last_char=${ima_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	ima_xattr=${ima_xattr:0:-1}$last_char
+
+	setfattr -n security.ima -v 0x$ima_xattr test-file 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Change of security.ima for test-file should not be allowed (immutable metadata)${NORM}"
+		return $FAIL
+	fi
+
+	# Repeat the test for ACLs.
+	msg=$(exec 2>&1 && setfacl --set u::rw,g::r,o::r,m:r test-file)
+	if [ $? -ne 0 ]; then
+		if [ "${msg%not supported}" != "$msg" ]; then
+			return $OK
+		fi
+
+		echo "${RED}Cannot preserve system.posix_acl_access for test-file${NORM}"
+		return $FAIL
+	fi
+
+	setfacl --set u::rw,g::r,o::r,m:rw test-file 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Change of system.posix_acl_access for test-file should not be allowed (immutable metadata)${NORM}"
+		return $FAIL
+	fi
+
+	if [ -n "$mountpoint_idmapped" ]; then
+		pushd $mountpoint_idmapped > /dev/null
+
+		# Repeat the test for ACLs on an idmapped mount.
+		#
+		# This test relies on the fact that the caller of this script (root) is in
+		# the same owning group of test-file (in the idmapped mount the group is
+		# root, not $METADATA_CHANGE_FOWNER and, for this reason, the S_ISGID bit
+		# is not cleared. If EVM was not aware of the mapping, it would have
+		# determined that root is not in the owning group of test-file and given
+		# that also CAP_FSETID is cleared, the S_ISGID bit would have been cleared
+		# and thus the operation would fail (file metadata changed).
+		capsh --drop='cap_fsetid' -- -c 'setfacl --set u::rw,g::r,o::r test-file'
+		if [ $? -ne 0 ]; then
+			echo "${RED}Cannot preserve system.posix_acl_access for test-file${NORM}"
+			popd
+			return $FAIL
+		fi
+
+		popd > /dev/null
+	fi
+
+	return $OK
+}
+
+cleanup_metadata_change() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_revalidate_status()
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# Note:
+# This test can be run if EVM_ALLOW_METADATA_WRITES is set in advance
+# before running this script. If it is not set before, this script sets
+# EVM_SETUP_COMPLETE, disabling further EVM mode modifications until reboot.
+#
+# Without EVM_ALLOW_METADATA_WRITES, EVM_SETUP_COMPLETE is necessary to ignore
+# the INTEGRITY_NOLABEL and INTEGRITY_NOXATTRS errors.
+#
+# The purpose of this test is to verify that IMA detected a metadata change
+# when EVM_ALLOW_METADATA_WRITES is set (metadata operations are always
+# allowed). After the first successful appraisal, the test intentionally changes
+# metadata and verifies that IMA revoked access to the file. The test also
+# verifies that IMA grants access again to the file after restoring the correct
+# metadata.
+check_evm_revalidate() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $evm_value -ne $(($EVM_INIT_X509 | $EVM_ALLOW_METADATA_WRITES)) ]; then
+		echo "${CYAN}EVM mode $(($EVM_INIT_X509 | $EVM_ALLOW_METADATA_WRITES)) required, execute echo 4 > /sys/kernel/security/evm before running this test${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	chmod 600 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	# We need to defer setting the correct owner, as there could be
+	# already an IMA policy rule preventing evmctl from reading the
+	# file to calculate the digest.
+	evmctl sign -o -a sha256 --imahash --uid $APPRAISE_FOWNER --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $APPRAISE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	check_load_ima_rule "$APPRAISE_RULE"
+	result=$?
+	if [ $result -ne $OK ]; then
+		return $result
+	fi
+
+	# Read the file so that IMA would not re-appraise it next time.
+	cat test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return $FAIL
+	fi
+
+	# After enabling metadata modification, operations should succeed even
+	# if the file has a portable signature. However, the previously cached
+	# appraisal status should be invalidated.
+	chmod 644 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Here check if IMA re-appraised the file. The read should fail
+	# since now file metadata is invalid.
+	cat test-file &> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Read of test-file should not succeed (invalid mode)${NORM}"
+		return $FAIL
+	fi
+
+	# Restore metadata back to the original value.
+	chmod 600 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot restore original mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Ensure that now IMA appraisal succeeds.
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file after restoring correct mode${NORM}"
+		return $FAIL
+	fi
+
+	if [ -n "$(which chcon 2> /dev/null)" ] && [ -n "$(which getenforce 2> /dev/null)" ] && [ "$(getenforce 2> /dev/null)" != "Disabled" ]; then
+		# Repeat the test for the SELinux label.
+		label=$(get_xattr security.selinux test-file)
+
+		chcon unconfined_u:object_r:null_device_t:s0 test-file
+		if [ $? -ne 0 ]; then
+			echo "${RED}Cannot change security.selinux of test-file${NORM}"
+			return $FAIL
+		fi
+
+		cat test-file &> /dev/null
+		if [ $? -eq 0 ]; then
+			echo "${RED}Read of test-file should not succeed (invalid security.selinux)${NORM}"
+			return $FAIL
+		fi
+
+		if [ -n "$label" ]; then
+			chcon $label test-file
+			if [ $? -ne 0 ]; then
+				echo "${RED}Cannot restore original security.selinux of test-file${NORM}"
+				return $FAIL
+			fi
+		else
+			attr -S -r selinux test-file
+		fi
+
+		cat test-file > /dev/null
+		if [ $? -ne 0 ]; then
+			echo "${RED}Cannot read test-file after restoring correct security.selinux${NORM}"
+			return $FAIL
+		fi
+	fi
+
+	# Repeat the test for the IMA signature.
+	ima_xattr=$(get_xattr security.ima test-file)
+	if [ -z "$ima_xattr" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return $FAIL
+	fi
+
+	last_char=${ima_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	ima_xattr_new=${ima_xattr:0:-1}$last_char
+
+	setfattr -n security.ima -v 0x$ima_xattr_new test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot set security.ima of test-file${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file &> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Read of test-file should not succeed (invalid security.ima)${NORM}"
+		return $FAIL
+	fi
+
+	setfattr -n security.ima -v 0x$ima_xattr test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot restore original security.ima of test-file${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file after restoring correct security.ima${NORM}"
+		return $FAIL
+	fi
+
+	# Repeat the test for the EVM signature.
+	evm_xattr=$(get_xattr security.evm test-file)
+	if [ -z "$evm_xattr" ]; then
+		echo "${RED}security.evm not found${NORM}"
+		return $FAIL
+	fi
+
+	last_char=${evm_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	evm_xattr_new=${evm_xattr:0:-1}$last_char
+
+	setfattr -n security.evm -v 0x$evm_xattr_new test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot set security.evm of test-file${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file &> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Read of test-file should not succeed (invalid security.evm)${NORM}"
+		return $FAIL
+	fi
+
+	setfattr -n security.evm -v 0x$evm_xattr test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot restore original security.evm of test-file${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file after restoring correct security.evm${NORM}"
+		return $FAIL
+	fi
+
+	# Repeat the test for ACLs.
+	setfacl -m u::rwx test-file 2> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change system.posix_acl_access${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file &> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "${RED}Read of test-file should not succeed (invalid system.posix_acl_access)${NORM}"
+		return $FAIL
+	fi
+
+	setfacl -m u::rw test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot restore original system.posix_acl_access for test-file${NORM}"
+		return $FAIL
+	fi
+
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file after restoring correct system.posix_acl_access${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_evm_revalidate() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Introduce evm_revalidate_status()
+# - ima: Allow imasig requirement to be satisfied by EVM portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that IMA manages files with an EVM
+# portable signature similarly to those with an IMA signature: content can be
+# written to new files after adding the signature and files can be accessed
+# when the imasig requirement is specified in the IMA policy.
+check_evm_portable_sig_ima_appraisal() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $((evm_value & EVM_INIT_X509)) -ne $EVM_INIT_X509 ]; then
+		echo "${CYAN}EVM flag $EVM_INIT_X509 required${NORM}"
+		return $SKIP
+	fi
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	chmod 600 test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return $FAIL
+	fi
+
+	# We need to defer setting the correct owner, as there could be
+	# already an IMA policy rule preventing evmctl from reading the
+	# file to calculate the digest.
+	evmctl sign -o -a sha256 --imahash --uid $APPRAISE_DIGSIG_FOWNER --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $APPRAISE_DIGSIG_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	check_load_ima_rule "$APPRAISE_DIGSIG_RULE"
+	result=$?
+	if [ $result -ne $OK ]; then
+		return $result
+	fi
+
+	# Ensure that a file with a portable signature satisfies the
+	# appraise_type=imasig requirement specified in the IMA policy.
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return $FAIL
+	fi
+
+	# Even files with a portable signature should be considered as
+	# immutable by IMA. Write should fail.
+	echo "test" 2> /dev/null >> test-file
+	if [ $? -eq 0 ]; then
+		echo "${RED}Write to test-file should not succeed (immutable metadata)${NORM}"
+		return $FAIL
+	fi
+
+	tar --xattrs-include=* -cf test-archive.tar test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	mkdir out
+
+	# Appraisal of the new file, extracted by tar, should succeed
+	# not only if the new file has an IMA signature but also if
+	# it has a portable signature.
+	tar --xattrs-include=* -xf test-archive.tar -C out
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return $FAIL
+	fi
+
+	# Check if xattrs have been correctly set.
+	xattr_orig=$(get_xattr security.selinux test-file)
+	xattr=$(get_xattr security.selinux out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.selinux mismatch between original and extracted file${NORM}"
+		return $FAIL
+	fi
+
+	xattr_orig=$(get_xattr security.ima test-file)
+	xattr=$(get_xattr security.ima out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.ima mismatch between original and extracted file${NORM}"
+		return $FAIL
+	fi
+
+	xattr_orig=$(get_xattr security.evm test-file)
+	xattr=$(get_xattr security.evm out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.evm mismatch between original and extracted file${NORM}"
+		return $FAIL
+	fi
+
+	# Check if attrs have been correctly set.
+	owner=$(stat -c "%u" out/test-file)
+	if [ "$owner" != "$APPRAISE_DIGSIG_FOWNER" ]; then
+		echo "${RED}owner mismatch between original and extracted file${NORM}"
+		return $FAIL
+	fi
+
+	mode=$(stat -c "%a" out/test-file)
+	if [ "$mode" != "600" ]; then
+		echo "${RED}mode mismatch between original and extracted file${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_evm_portable_sig_ima_appraisal() {
+	rm -f test-file test-archive.tar
+	rm -Rf out
+}
+
+# Requires:
+# - ima: Introduce template field evmsig and write to field sig as fallback
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is to verify that the EVM portable signature is
+# displayed in the measurement list.
+check_evm_portable_sig_ima_measurement_list() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	echo "test" > test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return $FAIL
+	fi
+
+	chown $MEASURE_FOWNER test-file
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return $FAIL
+	fi
+
+	evmctl sign -o -a sha256 --imahash --key $key_path test-file &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return $FAIL
+	fi
+
+	check_load_ima_rule "$MEASURE_RULE"
+	result=$?
+	if [ $result -ne $OK ]; then
+		return $result
+	fi
+
+	# Invalidate previous measurement to add new entry
+	touch test-file
+
+	# Read the file to add it to the measurement list.
+	cat test-file > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return $FAIL
+	fi
+
+	evm_sig_fs=$(get_xattr security.evm test-file)
+	if [ -z "$evm_sig_fs" ]; then
+		echo "${RED}security.evm not found${NORM}"
+		return $FAIL
+	fi
+
+	# Search security.evm in the measurement list.
+	evm_sig_list=$(cat /sys/kernel/security/ima/ascii_runtime_measurements | awk '$6 == "'$evm_sig_fs'"')
+	if [ -z "$evm_sig_list" ]; then
+		echo "${RED}security.evm mismatch (xattr != measurement list)${NORM}"
+		return $FAIL
+	fi
+
+	return $OK
+}
+
+cleanup_evm_portable_sig_ima_measurement_list() {
+	rm -f test-file
+}
+
+# Run in User Mode Linux.
+_run_user_mode ../linux $PWD/$(basename $0) "PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_EVM_CHANGE_MODE=$TST_EVM_CHANGE_MODE TST_KEY_PATH=$TST_KEY_PATH"
+
+# Run in User Mode Linux (skipped test).
+_run_user_mode ../linux $PWD/$(basename $0) "PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_EVM_CHANGE_MODE=$TST_EVM_CHANGE_MODE TST_KEY_PATH=$TST_KEY_PATH TST_LIST=check_evm_revalidate"
+
+# Exit from the parent if UML was used.
+_exit_user_mode ../linux
+
+# Mount filesystems in UML environment.
+_init_user_mode
+
+mountpoint=$(mktemp -d)
+image=$(mktemp)
+
+if [ -z "$mountpoint" ]; then
+	echo "${RED}Mountpoint directory not created${NORM}"
+	exit $FAIL
+fi
+
+if [ $(whoami) != "root" ]; then
+	echo "${CYAN}This script must be executed as root${NORM}"
+	exit $SKIP
+fi
+
+key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
+if [ -f "$PWD/../signing_key.pem" ]; then
+	key_path=$PWD/../signing_key.pem
+fi
+
+if [ -n "$TST_KEY_PATH" ]; then
+	key_path=$TST_KEY_PATH
+fi
+
+if [ ${key_path:0:1} != "/" ]; then
+	echo "${RED}Absolute path required for the signing key${NORM}"
+	exit $FAIL
+fi
+
+key_path_der=$(mktemp)
+
+if [ ! -f $key_path ]; then
+	echo "${CYAN}Kernel signing key not found in $key_path${NORM}"
+	exit $SKIP
+fi
+
+if [ ! -f "/sys/kernel/security/evm" ]; then
+	echo "${CYAN}EVM support in the kernel disabled${NORM}"
+	exit $SKIP
+fi
+
+# Assume that the EVM mode can be changed in a UML kernel
+if [ -f $PWD/../linux ]; then
+	TST_EVM_CHANGE_MODE=1
+fi
+
+evm_value=$(cat /sys/kernel/security/evm)
+
+openssl x509 -in $key_path -out $key_path_der -outform der
+cat $key_path_der | keyctl padd asymmetric pubkey %keyring:.ima &> /dev/null
+if [ $? -ne 0 ]; then
+	echo "${RED}Public key cannot be added to the IMA keyring${NORM}"
+	exit $FAIL
+fi
+
+dd if=/dev/zero of=$image bs=1M count=20 &> /dev/null
+if [ $? -ne 0 ]; then
+	echo "${RED}Cannot create test image${NORM}"
+	exit $FAIL
+fi
+
+dev=$(losetup -f $image --show)
+if [ -z "$dev" ]; then
+	echo "${RED}Cannot create loop device${NORM}"
+	exit $FAIL
+fi
+
+mkfs.ext4 -U $IMA_UUID -b 4096 $dev &> /dev/null
+if [ $? -ne 0 ]; then
+	echo "${RED}Cannot format $dev${NORM}"
+	exit $FAIL
+fi
+
+mount -o i_version $dev $mountpoint
+if [ $? -ne 0 ]; then
+	echo "${RED}Cannot mount loop device${NORM}"
+	exit $FAIL
+fi
+
+if [ -f ../mount-idmapped ]; then
+	mountpoint_idmapped=$(mktemp -d)
+	../mount-idmapped --map-mount b:$METADATA_CHANGE_FOWNER:0:1 $mountpoint $mountpoint_idmapped
+	if [ $? -ne 0 ]; then
+		echo "${RED}mount-idmapped failed${NORM}"
+		exit $FAIL
+	fi
+fi
+
+loop_mounted=1
+pushd $mountpoint > /dev/null
+
+expect_pass check_ima_sig_appraisal
+cleanup_ima_sig_appraisal
+expect_pass check_ima_sig_ima_measurement_list
+cleanup_ima_sig_ima_measurement_list
+
+if [ $(echo -e "$(uname -r)\n5.12" | sort -V | head -n 1) != "5.12" ]; then
+	exit $OK
+fi
+
+if [ $((evm_value & EVM_INIT_X509)) -ne $EVM_INIT_X509 ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	cat $key_path_der | keyctl padd asymmetric pubkey %keyring:.evm &> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "${RED}Public key cannot be added to the EVM keyring${NORM}"
+		exit $FAIL
+	fi
+
+	echo $EVM_INIT_X509 > /sys/kernel/security/evm 2> /dev/null
+fi
+
+if [ $(expr index "$TST_LIST" "check_evm_revalidate") -gt 0 ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	echo $EVM_ALLOW_METADATA_WRITES > /sys/kernel/security/evm 2> /dev/null
+fi
+
+# We cannot determine from securityfs if EVM_SETUP_COMPLETE is set, so we set it unless EVM_ALLOW_METADATA_WRITES is set.
+if [ $((evm_value & EVM_ALLOW_METADATA_WRITES)) -ne $EVM_ALLOW_METADATA_WRITES ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	echo $EVM_SETUP_COMPLETE > /sys/kernel/security/evm 2> /dev/null
+fi
+
+evm_value=$(cat /sys/kernel/security/evm)
+
+expect_pass check_create_file
+cleanup_create_file
+expect_pass check_cp_preserve_xattrs
+cleanup_cp_preserve_xattrs
+expect_pass check_tar_extract_xattrs_different_owner
+cleanup_tar_extract_xattrs_different_owner
+expect_pass check_tar_extract_xattrs_same_owner
+cleanup_tar_extract_xattrs_same_owner
+expect_pass check_metadata_change
+cleanup_metadata_change
+expect_pass check_evm_revalidate
+cleanup_evm_revalidate
+expect_pass check_evm_portable_sig_ima_appraisal
+cleanup_evm_portable_sig_ima_appraisal
+expect_pass check_evm_portable_sig_ima_measurement_list
+cleanup_evm_portable_sig_ima_measurement_list
-- 
2.25.1

