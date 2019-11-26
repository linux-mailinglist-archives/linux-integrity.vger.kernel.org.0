Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8372010A47A
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2019 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfKZT1q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 14:27:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbfKZT1q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 14:27:46 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQJQacq178365
        for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2019 14:27:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf19y4gav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2019 14:27:45 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Nov 2019 19:27:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 19:27:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQJRcN948693356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 19:27:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56DB84203F;
        Tue, 26 Nov 2019 19:27:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EA8642041;
        Tue, 26 Nov 2019 19:27:37 +0000 (GMT)
Received: from dhcp-9-31-103-87.watson.ibm.com (unknown [9.31.103.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 19:27:36 +0000 (GMT)
Subject: Re: One question about trusted key of keyring in Linux kernel.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Date:   Tue, 26 Nov 2019 14:27:36 -0500
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112619-0020-0000-0000-0000038F5B71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112619-0021-0000-0000-000021E6604C
Message-Id: <1574796456.4793.248.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_06:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260163
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-26 at 07:32 +0000, Zhao, Shirley wrote:
> Thanks for your feedback, Mimi. 
> But the document of dracut can't solve my problem. 
> 
> I did more test these days and try to descript my question in more detail. 
> 
> In my scenario, the trusted key will be sealed into TPM with PCR policy. 
> And there are some related options in manual like 
>        hash=         hash algorithm name as a string. For TPM 1.x the only
>                      allowed value is sha1. For TPM 2.x the allowed values
>                      are sha1, sha256, sha384, sha512 and sm3-256.
>        policydigest= digest for the authorization policy. must be calculated
>                      with the same hash algorithm as specified by the 'hash='
>                      option.
>        policyhandle= handle to an authorization policy session that defines the
>                      same policy and with the same hash algorithm as was used to
>                      seal the key. 
> 
> Here is my test step. 
> Firstly, the pcr policy is generated as below: 
> $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy pcr7_bin.policy > pcr7.policy
> 
> Pcr7.policy is the ascii hex of policy:
> $ cat pcr7.policy
> 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> 
> Then generate the trusted key and configure policydigest and get the key ID: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256 policydigest=`cat pcr7.policy`" @u
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
> $ tpm2_policypcr -S session.ctx -L sha256:7 -F pcr7.sha256 -f pcr7.policy
> policy-digest: 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> 
> Input the policy handle to load trusted key:
> $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001 policyhandle=0x3000000" @u
> add_key: Operation not permitted
> 
> The error should be policy check failed, because I use TPM command to unseal directly with error of policy check failed. 
> $ tpm2_unseal -c 0x81000001 -L sha256:7
> ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) - tpm:session(1):a policy check failed
> ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run tpm2_unseal
> 
> So my question is:
> 1. How to use the option, policydigest, policyhandle?? Is there any example? 
> 2. What's wrong with my test step? 

When reporting a problem please state which kernel is experiencing
this problem.  Recently there was a trusted key regression.  Refer to
commit e13cd21ffd50 "tpm: Wrap the buffer from the caller to tpm_buf
in tpm_send()" for the details.

Before delving into this particular problem, first please make sure
you are able to create, save, remove, and then reload a trusted key
not sealed to a PCR.

Mimi 

