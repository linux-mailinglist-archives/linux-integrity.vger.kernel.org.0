Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5510EF99
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLBSzo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:55:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727556AbfLBSzo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:55:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2ImcZf038665;
        Mon, 2 Dec 2019 13:55:37 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6c0r1br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 13:55:36 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB2IsmlW022082;
        Mon, 2 Dec 2019 18:55:36 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 2wkg26d5e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 18:55:36 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2ItZm233030514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 18:55:35 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 424DE78067;
        Mon,  2 Dec 2019 18:55:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525F878060;
        Mon,  2 Dec 2019 18:55:33 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.221.34])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 18:55:33 +0000 (GMT)
Message-ID: <1575312932.24227.13.camel@linux.ibm.com>
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
Date:   Mon, 02 Dec 2019 10:55:32 -0800
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
         <1575269075.4080.31.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_04:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=922
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912020160
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-02 at 06:50 +0000, Zhao, Shirley wrote:
> So I guess mostly like, it is the format of policydigest,
> policyhandle is not correctly in my keyctl command. 
> But what is the correct using?
> 
> My keyctl commands are attached as below: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr7.policy`" @u
> 874117045
> 
> Save the trusted key. 
> $ keyctl pipe 874117045 > kmk.blob

OK, looking at the actual code, it seems that whoever wrote it didn't
account for the differences between TPM1.2 and TPM2.0.  With TPM2.0
TPM2_Create returns the public and private parts plus three other tpm2b
entites used to certify and check the key.  When you load the blob back
using TPM2_Load, it only accepts the public and private parts. 
However, your blob contains the other extraneous elements, that's why
it can't be loaded.  You could make it loadable by stripping off the
extraneous pieces ... just take the first two tpm2b elements of the
blob but it looks like we need to fix the API.  I suppose the good news
is given this failure that we have the opportunity to rewrite the API
since no-one else can have used it for anything because of this.  The
fundamental problem with the current API is that most TPM2's only have
three available session registers.  It's simply not scalable to set
them up in userspace and have the kernel use them, so what we should be
doing is passing down the actual policy and having the kernel construct
the session at the point of use and then flush it, thus solving the
potential session exhaustion issue.

I'd actually propose we make a TSSLOADABLE the fundamental element of
operation for trusted keys.  The IBM and Intel TSS people have agreed
to do this as the format for TPM loadable keys, but it should also
apply to sealed data.  The beauty of TSSLOADABLE is that the ASN.1
format includes a policy specification:

/*
 * TSSLOADABLE ::= SEQUENCE {
 *	type		OBJECT IDENTIFIER
 *	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL
 *	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
 *	secret		[2] EXPLICIT OCTET STRING OPTIONAL
 *	parent		INTEGER
 *	pubkey		OCTET STRING
 *	privkey		OCTET STRING
 * }
 * TPMPolicy ::= SEQUENCE {
 *	CommandCode		[0] EXPLICIT INTEGER
 *	CommandPolicy		[1] EXPLICIT OCTET STRING
 * }
 */

James

