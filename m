Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9A409F8F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhIMWTp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237860AbhIMWTn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DLTtQC018005
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=CXrakC8ntfbOCHaCH7cb1zBVokug/IbiYdyLSVBC6Dg=;
 b=iR86E6UbEbWbcgGUzhFaqGez2YvfK6JzhunP6EkoMVgOlM6gbe2jx0vj1kD3LbBfRRD9
 4xQkTtIYo3wni5Azx0ncVH1VJ1W+RLGDOghrDfUzGHEAMIFeZgTwBCYjfp7B42VvEi7Y
 9i2pIXPuD16rbYlgthhawWPfvH978phuH6gc+Sz7s9dedAXcSaGHcwrD7YC9i/Ns1BE+
 1E45QN5UOv1UIPD6ia31vhdFxm425hZ0z/EuEjwa3ZJI60ugA3kPefOjkNw6W42wsl4y
 qn6UjhMo93j3sie5ruEjRjkjyL5MC+KTn+xI7xrDEo44kNwd3Y90LBfe19dPhdlKdaCJ QA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b23hdtj3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:26 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMGprg032043
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:25 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3b0m3ad8df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:25 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMINLJ45744396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3760BE054;
        Mon, 13 Sep 2021 22:18:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7683EBE05D;
        Mon, 13 Sep 2021 22:18:23 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:23 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 7/9] tests: Import softhsm_setup script to enable pkcs11 test case
Date:   Mon, 13 Sep 2021 18:18:11 -0400
Message-Id: <20210913221813.2554880-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: px1kk4ZHR94pbFxPItQsh6NF0Q0fdIXB
X-Proofpoint-ORIG-GUID: px1kk4ZHR94pbFxPItQsh6NF0Q0fdIXB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130048
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Import softhsm_setup script from my swtpm project and contribute
it to this project under dual license BSD 3-clause and GLP 2.0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/softhsm_setup | 293 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 293 insertions(+)
 create mode 100755 tests/softhsm_setup

diff --git a/tests/softhsm_setup b/tests/softhsm_setup
new file mode 100755
index 0000000..35b1754
--- /dev/null
+++ b/tests/softhsm_setup
@@ -0,0 +1,293 @@
+#!/usr/bin/env bash
+
+# SPDX-License-Identifier: GPL-2.0 and BSD-3-clause
+# This program originates from 'swtpm' project (https://github.com/stefanberger/swtpm/)
+
+if [ -z "$(type -P p11tool)" ]; then
+	echo "Need p11tool from gnutls"
+	exit 77
+fi
+
+if [ -z "$(type -P softhsm2-util)" ]; then
+	echo "Need softhsm2-util from softhsm2 package"
+	exit 77
+fi
+
+MAJOR=$(softhsm2-util -v | cut -d '.' -f1)
+MINOR=$(softhsm2-util -v | cut -d '.' -f2)
+if [ ${MAJOR} -lt 2 ] || [ ${MAJOR} -eq 2 -a ${MINOR} -lt 2 ]; then
+	echo "Need softhsm v2.2.0 or later"
+	exit 77
+fi
+
+NAME=swtpm-test
+PIN=${PIN:-1234}
+SO_PIN=${SO_PIN:-1234}
+SOFTHSM_SETUP_CONFIGDIR=${SOFTHSM_SETUP_CONFIGDIR:-~/.config/softhsm2}
+export SOFTHSM2_CONF=${SOFTHSM_SETUP_CONFIGDIR}/softhsm2.conf
+
+UNAME_S="$(uname -s)"
+
+case "${UNAME_S}" in
+Darwin)
+	msg=$(sudo -v -n)
+	if [ $? -ne 0 ]; then
+		echo "Need password-less sudo rights on OS X to change /etc/gnutls/pkcs11.conf"
+		exit 1
+	fi
+	;;
+esac
+
+teardown_softhsm() {
+	local configdir=${SOFTHSM_SETUP_CONFIGDIR}
+	local configfile=${SOFTHSM2_CONF}
+	local bakconfigfile=${configfile}.bak
+	local tokendir=${configdir}/tokens
+
+	softhsm2-util --token "${NAME}" --delete-token &>/dev/null
+
+	case "${UNAME_S}" in
+	Darwin*)
+		if [ -f /etc/gnutls/pkcs11.conf.bak ]; then
+			sudo rm -f /etc/gnutls/pkcs11.conf
+			sudo mv /etc/gnutls/pkcs11.conf.bak \
+			   /etc/gnutls/pkcs11.conf &>/dev/null
+		fi
+		;;
+	esac
+
+	if [ -f "$bakconfigfile" ]; then
+		mv "$bakconfigfile" "$configfile"
+	else
+		rm -f "$configfile"
+	fi
+	if [ -d "$tokendir" ]; then
+		rm -rf "${tokendir}"
+	fi
+	return 0
+}
+
+setup_softhsm() {
+	local msg tokenuri keyuri
+	local configdir=${SOFTHSM_SETUP_CONFIGDIR}
+	local configfile=${SOFTHSM2_CONF}
+	local bakconfigfile=${configfile}.bak
+	local tokendir=${configdir}/tokens
+	local rc
+
+	case "${UNAME_S}" in
+	Darwin*)
+		if [ -f /etc/gnutls/pkcs11.conf.bak ]; then
+			echo "/etc/gnutls/pkcs11.conf.bak already exists; need to 'teardown' first"
+			return 1
+		fi
+		sudo mv /etc/gnutls/pkcs11.conf \
+			/etc/gnutls/pkcs11.conf.bak &>/dev/null
+		if [ $(id -u) -eq 0 ]; then
+			SONAME="$(sudo -u nobody brew ls --verbose softhsm | \
+				  grep -E "\.so$")"
+		else
+			SONAME="$(brew ls --verbose softhsm | \
+				  grep -E "\.so$")"
+		fi
+		sudo mkdir -p /etc/gnutls &>/dev/null
+		sudo bash -c "echo "load=${SONAME}" > /etc/gnutls/pkcs11.conf"
+		;;
+	esac
+
+	if ! [ -d $configdir ]; then
+		mkdir -p $configdir
+	fi
+	mkdir -p ${tokendir}
+
+	if [ -f $configfile ]; then
+		mv "$configfile" "$bakconfigfile"
+	fi
+
+	if ! [ -f $configfile ]; then
+		cat <<_EOF_ > $configfile
+directories.tokendir = ${tokendir}
+objectstore.backend = file
+log.level = DEBUG
+slots.removable = false
+_EOF_
+	fi
+
+	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}" | tail -n1)
+	if [ $? -ne 0 ]; then
+		echo "Could not list existing tokens"
+		echo "$msg"
+	fi
+	tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+
+	if [ -z "$tokenuri" ]; then
+		msg=$(softhsm2-util \
+			--init-token --pin ${PIN} --so-pin ${SO_PIN} \
+			--free --label ${NAME} 2>&1)
+		if [ $? -ne 0 ]; then
+			echo "Could not initialize token"
+			echo "$msg"
+			return 2
+		fi
+
+		slot=$(echo "$msg" | \
+		       sed -n 's/.* reassigned to slot \([0-9]*\)$/\1/p')
+		if [ -z "$slot" ]; then
+			slot=$(softhsm2-util --show-slots | \
+			       grep -E "^Slot " | head -n1 |
+			       sed -n 's/Slot \([0-9]*\)/\1/p')
+			if [ -z "$slot" ]; then
+				echo "Could not parse slot number from output."
+				echo "$msg"
+				return 3
+			fi
+		fi
+
+		msg=$(p11tool --list-tokens 2>&1 | \
+			grep "token=${NAME}" | tail -n1)
+		if [ $? -ne 0 ]; then
+			echo "Could not list existing tokens"
+			echo "$msg"
+		fi
+		tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+		if [ -z "${tokenuri}" ]; then
+			echo "Could not get tokenuri!"
+			return 4
+		fi
+
+		# more recent versions of p11tool have --generate-privkey ...
+		msg=$(GNUTLS_PIN=$PIN p11tool \
+			--generate-privkey=rsa --bits 2048 --label mykey --login \
+			"${tokenuri}" 2>&1)
+		if [ $? -ne 0 ]; then
+			# ... older versions have --generate-rsa
+			msg=$(GNUTLS_PIN=$PIN p11tool \
+				--generate-rsa --bits 2048 --label mykey --login \
+				"${tokenuri}" 2>&1)
+			if [ $? -ne 0 ]; then
+				echo "Could not create RSA key!"
+				echo "$msg"
+				return 5
+			fi
+		fi
+	fi
+
+	getkeyuri_softhsm $slot
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		teardown_softhsm
+	fi
+
+	return $rc
+}
+
+_getkeyuri_softhsm() {
+	local msg tokenuri keyuri
+
+	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}")
+	if [ $? -ne 0 ]; then
+		echo "Could not list existing tokens"
+		echo "$msg"
+		return 5
+	fi
+	tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+	if [ -z "$tokenuri" ]; then
+		echo "Could not get token URL"
+		echo "$msg"
+		return 6
+	fi
+	msg=$(p11tool --list-all ${tokenuri} 2>&1)
+	if [ $? -ne 0 ]; then
+		echo "Could not list object under token $tokenuri"
+		echo "$msg"
+		softhsm2-util --show-slots
+		return 7
+	fi
+
+	keyuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+	if [ -z "$keyuri" ]; then
+		echo "Could not get key URL"
+		echo "$msg"
+		return 8
+	fi
+	echo "$keyuri"
+	return 0
+}
+
+getkeyuri_softhsm() {
+	local keyuri rc
+
+	keyuri=$(_getkeyuri_softhsm)
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		return $rc
+	fi
+	echo "keyuri: $keyuri?pin-value=${PIN}" #&module-name=softhsm2"
+	return 0
+}
+
+getpubkey_softhsm() {
+	local keyuri rc
+
+	keyuri=$(_getkeyuri_softhsm)
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		return $rc
+	fi
+	GNUTLS_PIN=${PIN} p11tool --export-pubkey "${keyuri}" --login 2>/dev/null
+	return $?
+}
+
+usage() {
+	cat <<_EOF_
+Usage: $0 [command]
+
+Supported commands are:
+
+setup      : Setup the user's account for softhsm and create a
+             token and key with a test configuration
+
+getkeyuri  : Get the key's URI; may only be called after setup
+
+getpubkey  : Get the public key in PEM format; may only be called after setup
+
+teardown   : Remove the temporary softhsm test configuration
+
+_EOF_
+}
+
+main() {
+	local ret
+
+	if [ $# -lt 1 ]; then
+		usage $0
+		echo -e "Missing command.\n\n"
+		return 1
+	fi
+	case "$1" in
+	setup)
+		setup_softhsm
+		ret=$?
+		;;
+	getkeyuri)
+		getkeyuri_softhsm
+		ret=$?
+		;;
+	getpubkey)
+		getpubkey_softhsm
+		ret=$?
+		;;
+	teardown)
+		teardown_softhsm
+		ret=$?
+		;;
+	*)
+		echo -e "Unsupported command: $1\n\n"
+		usage $0
+		ret=1
+	esac
+	return $ret
+}
+
+main "$@"
+exit $?
-- 
2.31.1

