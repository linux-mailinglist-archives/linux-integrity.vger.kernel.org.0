Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64ED403FCA
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350447AbhIHTZA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:25:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350394AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J49ek168094
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=KulE2AiTFulMSqJuc2SHH0+HX8ClDBjTgQ81tc9Uhdc=;
 b=j94uHqp1ATNE10zCUmyjyktMHEw7Uws+iaQNJGF87ntwKEejWRHuWaYp1HUMerHY1vgy
 gNnk9mpgOMZVYDCTzAo42Xg1iE9FRV7ZdtQprc86k1cE47Ev/MZkzd/rulazRiom+0gZ
 Ii3srtwbdNHkxpSlGpO1XU+ktbcli6Ftge4INTsLMgy0hkINSExlus5I6eV8Eq6w33UW
 7U/i/b2iKNfs0iFY5YXgqED2EaP/ePAkim0hRo4ELVRWF/pSncrr1AGPOlC0rFrZ0fy0
 5dF6LcvdDjZqWpHcGRTOkcruwyMm+G6gtaX2lUE1V7bLXjSQPGz40y83ha4T9SpYuSIp lA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axy0af957-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JIIx4015784
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3axcnnufes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjvq16580938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0AE1112066;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A74C811206D;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 7/9] tests: Import softhsm_setup script to enable pkcs11 test case
Date:   Wed,  8 Sep 2021 15:23:41 -0400
Message-Id: <20210908192343.4147739-8-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5wIOV9-Ka9V0YSKxXUkPMJQDS5QtLS9I
X-Proofpoint-ORIG-GUID: 5wIOV9-Ka9V0YSKxXUkPMJQDS5QtLS9I
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Import softhsm_setup script from my swtpm project and contribute
it to this project under dual license BSD 3-clause and GLP 2.0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/softhsm_setup | 297 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)
 create mode 100755 tests/softhsm_setup

diff --git a/tests/softhsm_setup b/tests/softhsm_setup
new file mode 100755
index 0000000..fe69a6e
--- /dev/null
+++ b/tests/softhsm_setup
@@ -0,0 +1,297 @@
+#!/usr/bin/env bash
+
+# This program originates from 'swtpm' project (https://github.com/stefanberger/swtpm/)
+# and is provided to ima-evm-utils under a dual license:
+# - BSD 3-clause
+# - GPL-2.0
+
+# This script may not work with softhsm2 2.0.0 but with >= 2.2.0
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

