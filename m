Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C348310B529
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0SH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 13:07:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfK0SH2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 13:07:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARI4woc038018;
        Wed, 27 Nov 2019 13:06:23 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxr3xhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:06:23 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xARI50D0028595;
        Wed, 27 Nov 2019 18:06:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2wevd70s2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 18:06:21 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARI6K8628442992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 18:06:20 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 758F6136055;
        Wed, 27 Nov 2019 18:06:20 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC3813604F;
        Wed, 27 Nov 2019 18:06:18 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.134.245])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Nov 2019 18:06:18 +0000 (GMT)
Message-ID: <1574877977.3551.5.camel@linux.ibm.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Date:   Wed, 27 Nov 2019 10:06:17 -0800
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-26 at 07:32 +0000, Zhao, Shirley wrote:
> Thanks for your feedback, Mimi. 
> But the document of dracut can't solve my problem. 
> 
> I did more test these days and try to descript my question in more
> detail. 
> 
> In my scenario, the trusted key will be sealed into TPM with PCR
> policy. 
> And there are some related options in manual like 
>        hash=         hash algorithm name as a string. For TPM 1.x the
> only
>                      allowed value is sha1. For TPM 2.x the allowed
> values
>                      are sha1, sha256, sha384, sha512 and sm3-256.
>        policydigest= digest for the authorization policy. must be
> calculated
>                      with the same hash algorithm as specified by the
> 'hash='
>                      option.
>        policyhandle= handle to an authorization policy session that
> defines the
>                      same policy and with the same hash algorithm as
> was used to
>                      seal the key. 
> 
> Here is my test step. 
> Firstly, the pcr policy is generated as below: 
> $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy
> pcr7_bin.policy > pcr7.policy
> 
> Pcr7.policy is the ascii hex of policy:
> $ cat pcr7.policy
> 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> 
> Then generate the trusted key and configure policydigest and get the
> key ID: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr7.policy`" @u
> 874117045
> 
> Save the trusted key. 
> $ keyctl pipe 874117045 > kmk.blob
> 
> Reboot and load the key. 
> Start a auth session to generate the policy:
> $ tpm2_startauthsession -S session.ctx
> session-handle: 0x3000000
> $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256
> $ tpm2_policypcr -S session.ctx -L sha256:7 -F pcr7.sha256 -f
> pcr7.policy
> policy-digest:
> 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> 
> Input the policy handle to load trusted key:
> $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001
> policyhandle=0x3000000" @u
> add_key: Operation not permitted
> 
> The error should be policy check failed, because I use TPM command to
> unseal directly with error of policy check failed. 
> $ tpm2_unseal -c 0x81000001 -L sha256:7
> ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) -
> tpm:session(1):a policy check failed
> ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run
> tpm2_unseal

I think there's a miscommunication here: you're complaining about the
error returned from a trusted key unseal operation that *should* fail,
correct?  You think it should return a TPM error but instead it returns
-EPERM.  That's completely correct: we translate all TPM errors into
linux ones as we pass them up to userspace, so the best we can do is
operation not permitted.

James

