Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C260685DA3
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 04:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBADDF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 22:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjBADDD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 22:03:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506C12F00;
        Tue, 31 Jan 2023 19:02:57 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3110URuj018538;
        Wed, 1 Feb 2023 03:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ogU7BYB2rzWrmmoora2poV3Lw53TDHEi6v/ga3d2n7s=;
 b=F3P7oV2DIfqcqd/axgXnw16VQITk9Y8wLEngQEQ3PzItgiz1nDlq1eZcgSqDb9K+/FDl
 rK+DLqbqjdNBRAOBkl/1ubQa6IgIq3zh+zgnk6DlCHF3FmLTdRAVXCkOE8aVrvT0LVod
 cMSss2hJe3lXVpAsYFcZHmS4G/z0p0gWSjQJnRFE74PdDvFqcdD8Jvi5k5Nwnqi6b2Qt
 TcPd+7mMixSOUsVFiOceEGqgmTc6ljQW+Tf2p2nfn6KCvlJPzMa28f4ipsJaEkB8d2RE
 3pHg3KhSPbYwLes9xv3oiAE/5UOMLqXzu9Ky1yQlMszvCc+WjTY3oGApizqFkdOcuqGb Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfag0ettc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 03:02:38 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3112iaiI016245;
        Wed, 1 Feb 2023 03:02:37 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfag0etss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 03:02:37 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3111IoOj019228;
        Wed, 1 Feb 2023 03:02:36 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ncvuqr6bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 03:02:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31132Y1D31326624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 03:02:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D82AA5804B;
        Wed,  1 Feb 2023 03:02:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB2558055;
        Wed,  1 Feb 2023 03:02:33 +0000 (GMT)
Received: from sig-9-77-155-214.ibm.com (unknown [9.77.155.214])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 03:02:33 +0000 (GMT)
Message-ID: <c5d2e56c923645ec6e0ac8de15123c123db271ee.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 31 Jan 2023 22:02:32 -0500
In-Reply-To: <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zSGbh2abrnZHfU-JlT2lqEZn_-yWk8kI
X-Proofpoint-ORIG-GUID: UbfYRPy35ePT9kHdd3jDR49k8N5gW9HA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=795 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

> +check_mmap() {
> +	local hook="$1"
> +	local arg="$2"
> +	local test_file fowner rule result test_file_entry
> +
> +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> +
> +	if ! test_file=$(mktemp -p "$PWD"); then
> +		echo "${RED}Cannot write $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	fowner="$MMAP_CHECK_FOWNER"
> +	rule="$MEASURE_MMAP_CHECK_RULE"
> +
> +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> +	fi
> +
> +	if ! chown "$fowner" "$test_file"; then
> +		echo "${RED}Cannot change owner of $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	check_load_ima_rule "$rule"
> +	result=$?
> +	if [ $result -ne "$OK" ]; then
> +		return $result
> +	fi
> +
> +	test_mmap "$test_file" "$arg"
> +
> +	if [ "$TFAIL" != "yes" ]; then
> +		echo -n "Result (expect found): "
> +	else
> +		echo -n "Result (expect not found): "
> +	fi
> +
> +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> +	if [ -z "$test_file_entry" ]; then
> +		echo "not found"
> +		return "$FAIL"
> +	fi

Using temporary files should prevent having multiple records.  Having a
verbose option to show the actual matching measurement list record
would be nice.

> +
> +	echo "found"
> +	return "$OK"
> +}
> +



> +
> +# Run in the new environment if TST_ENV is set.
> +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> +
> +# Exit from the creator of the new environment.
> +_exit_env "$TST_KERNEL"
> +
> +# Mount filesystems in the new environment.
> +_init_env
> +
> +if [ "$(whoami)" != "root" ]; then
> +	echo "${CYAN}This script must be executed as root${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if [ ! -f /sys/kernel/security/ima/policy ]; then
> +	echo "${CYAN}IMA policy file not found${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if ! cat /sys/kernel/security/ima/policy &> /dev/null; then
> +	echo "${CYAN}IMA policy file is not readable${NORM}"
> +	exit "$SKIP"
> +fi

An existing policy with an mmap rule would affect this test.  Check to
see if one already exists.

> +
> +if [ -n "$TST_KEY_PATH" ]; then
> +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> +		echo "${RED}Absolute path required for the signing key${NORM}"
> +		exit "$FAIL"
> +	fi
> 

-- 
thanks,

Mimi

