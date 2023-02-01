Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F3686D72
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBARyz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjBARyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 12:54:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD211EBF3;
        Wed,  1 Feb 2023 09:54:50 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311HgFFc015267;
        Wed, 1 Feb 2023 17:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=N7qSMbci8FEjztY5CzpIeTmbHeOssC/j5k3N8k/6eYA=;
 b=CwXFWdqrI8aeP8zPvYDlurk4Avbm6af/eoPZorC8ETmheQCMA6/rIYphoeO7WOCYxCVw
 Ie7Ysd+fQQG1EEl2QShfHKjaiK8lF/T8QDIZSwi9SRMu/ozOckiVN8zSqq0czLVpEMk/
 go3AJj1YCHTnXJowzFcqC6WAPNigUicyeIPgbxDOvV94XiKbfonPFH0ZAaUvXMplu7Tm
 uPG8rVWFYyjQoqSYuOg/8K2J5v0Nh+tHleqmaQFt1a1ksIin8ExEzWyNRVfKHHt/C+Bu
 vvMPtRaBSsrflAxQwHtLeocBtDaQb95qiWO7kTnMzwnR3kNK9EUTWVLqvzk+mb0ecaWK mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfvq589jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 17:54:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 311HqoDL027346;
        Wed, 1 Feb 2023 17:54:31 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfvq589hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 17:54:31 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311G05RY006481;
        Wed, 1 Feb 2023 17:54:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtmmnxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 17:54:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311HsSE221496328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 17:54:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 894A558059;
        Wed,  1 Feb 2023 17:54:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB6658053;
        Wed,  1 Feb 2023 17:54:27 +0000 (GMT)
Received: from sig-9-77-155-160.ibm.com (unknown [9.77.155.160])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 17:54:27 +0000 (GMT)
Message-ID: <acc5495c0bef99f255c4e16f47c2a23dd450d5ad.camel@linux.ibm.com>
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
Date:   Wed, 01 Feb 2023 12:54:26 -0500
In-Reply-To: <4a01d975f20f842284da4f46da4eee8c0091f354.camel@huaweicloud.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
         <c5d2e56c923645ec6e0ac8de15123c123db271ee.camel@linux.ibm.com>
         <4a01d975f20f842284da4f46da4eee8c0091f354.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZjTsg3ImgvP4TpAlQk5XsrDQwt910tE_
X-Proofpoint-ORIG-GUID: lEjnkkzPCNsMvewQtHWZgcjmzfdWnO3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=855 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-01 at 18:29 +0100, Roberto Sassu wrote:
> On Tue, 2023-01-31 at 22:02 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > > +check_mmap() {
> > > +	local hook="$1"
> > > +	local arg="$2"
> > > +	local test_file fowner rule result test_file_entry
> > > +
> > > +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> > > +
> > > +	if ! test_file=$(mktemp -p "$PWD"); then
> > > +		echo "${RED}Cannot write $test_file${NORM}"
> > > +		return "$HARDFAIL"
> > > +	fi
> > > +
> > > +	fowner="$MMAP_CHECK_FOWNER"
> > > +	rule="$MEASURE_MMAP_CHECK_RULE"
> > > +
> > > +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> > > +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> > > +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> > > +	fi
> > > +
> > > +	if ! chown "$fowner" "$test_file"; then
> > > +		echo "${RED}Cannot change owner of $test_file${NORM}"
> > > +		return "$HARDFAIL"
> > > +	fi
> > > +
> > > +	check_load_ima_rule "$rule"
> > > +	result=$?
> > > +	if [ $result -ne "$OK" ]; then
> > > +		return $result
> > > +	fi
> > > +
> > > +	test_mmap "$test_file" "$arg"
> > > +
> > > +	if [ "$TFAIL" != "yes" ]; then
> > > +		echo -n "Result (expect found): "
> > > +	else
> > > +		echo -n "Result (expect not found): "
> > > +	fi
> > > +
> > > +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> > > +	if [ -z "$test_file_entry" ]; then
> > > +		echo "not found"
> > > +		return "$FAIL"
> > > +	fi
> > 
> > Using temporary files should prevent having multiple records.  Having a
> > verbose option to show the actual matching measurement list record
> > would be nice.
> > 
> > > +
> > > +	echo "found"
> > > +	return "$OK"
> > > +}
> > > +
> > 
> > 
> > > +
> > > +# Run in the new environment if TST_ENV is set.
> > > +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> > > +
> > > +# Exit from the creator of the new environment.
> > > +_exit_env "$TST_KERNEL"
> > > +
> > > +# Mount filesystems in the new environment.
> > > +_init_env
> > > +
> > > +if [ "$(whoami)" != "root" ]; then
> > > +	echo "${CYAN}This script must be executed as root${NORM}"
> > > +	exit "$SKIP"
> > > +fi
> > > +
> > > +if [ ! -f /sys/kernel/security/ima/policy ]; then
> > > +	echo "${CYAN}IMA policy file not found${NORM}"
> > > +	exit "$SKIP"
> > > +fi
> > > +
> > > +if ! cat /sys/kernel/security/ima/policy &> /dev/null; then
> > > +	echo "${CYAN}IMA policy file is not readable${NORM}"
> > > +	exit "$SKIP"
> > > +fi
> > 
> > An existing policy with an mmap rule would affect this test.  Check to
> > see if one already exists.
> 
> Not sure about this. We are specifying the filesystem UUID and the file
> owner. Should be enough to avoid interferences. Also
> check_load_ima_rule() avoids duplicated rules.

Since the policy rules are walked sequentially, existing mmap rules
without the uuid or owner qualifiers will interfere with the test
policy rules.   To see the problem load a custom policy containing an
mmap rule, without any qualifiers.  Then run the mmap_check test.

> 
> > > +
> > > +if [ -n "$TST_KEY_PATH" ]; then
> > > +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> > > +		echo "${RED}Absolute path required for the signing key${NORM}"
> > > +		exit "$FAIL"
> > > +	fi
> > > 
> 


