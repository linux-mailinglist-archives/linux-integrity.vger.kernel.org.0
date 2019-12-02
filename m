Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8374010E507
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 05:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLBERJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Dec 2019 23:17:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfLBERJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Dec 2019 23:17:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB24CJTm050963;
        Sun, 1 Dec 2019 23:17:04 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6smb4wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Dec 2019 23:17:04 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB24DS4M026084;
        Mon, 2 Dec 2019 04:17:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2wkg25qed9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 04:17:08 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB24H2S944302720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 04:17:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1FE28060;
        Mon,  2 Dec 2019 04:17:02 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A01228058;
        Mon,  2 Dec 2019 04:17:01 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.189.151])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 04:17:01 +0000 (GMT)
Message-ID: <1575260220.4080.17.camel@linux.ibm.com>
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
Date:   Sun, 01 Dec 2019 20:17:00 -0800
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-01_04:2019-11-29,2019-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=961 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020035
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-02 at 01:44 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> The value of PCR7 is not changed. I have checked it with TPM command
> tpm_pcrlist. 
> 
> So I think the problem is how to use the option policydigest and
> policyhandle? Is there any example?
> Maybe the format in my command is not correct. 

OK, so previously you said that using the Intel TSS the policy also
failed after a reboot:

> The error should be policy check failed, because I use TPM command to
> unseal directly with error of policy check failed. 
> $ tpm2_unseal -c 0x81000001 -L sha256:7
> ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) -
> tpm:session(1):a policy check failed
> ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run
> tpm2_unseal

So this must mean the actual policy hash you constructed was wrong in
some way: it didn't correspond simply to a value of pcr7 ... well
assuming the -L sha256:7 means construct a policy of the sha256 value
of pcr7 and use it in the unseal.

I can tell you how to construct policies using TPM2 commands, but I
think you want to know how to do it using the Intel TSS?  In which case
you really need to consult the experts in that TSS, like Phil Tricca.

For the plain TPM2 case, the policy looks like

TPM_CC_PolicyPCR || pcrs || pcrDigest

Where TPM_CC_PolicyPCR = 0000017f and for selecting pcr7 only.  pcrs is
a complicated entity: it's a counted array of pcr selections.  For your
policy you only need one entry, so it would be 00000001 followed by a
single pcrSelection entry.  pcrSelection is the hash algorithm, the
size of the selection bitmap (always 3 since every current TPM only has
24 PCRs) and a bitmap selecting the PCRs in big endian format, so for
PCR7 using sha256 (algorithm 000b), pcrSelection = 000b 03 80 00 00. 
And then you follow this by the hash of the PCR value you're looking
for.  The policyhash becomes the initial policy (all zeros for the
start of the policy chain) hashed with this.

Regards,

James

