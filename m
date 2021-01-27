Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D33305DE8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhA0OJ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 09:09:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232364AbhA0OHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 09:07:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RE3ZBA085244;
        Wed, 27 Jan 2021 09:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+gfgqu1/y4U3OJv7ojaSu7rxLiM7tLb8oobzVquqwV4=;
 b=nu2oJMrFm75kebCqEWQNyB1TugzytjW5QIwYfCD0IIDo7y73zN/7vtZUQEJf4iVu+itM
 ErpMTmvJ0QUuWgpRNOoTxlNnrN1l9jfPvH/PrTus2qU7Bh8mSHgI9d8WvB/e+w+Sa+Z4
 g3MAnpgore1BWi4feT939UWGPCUGno0bqBlaIYRNhVwRBRVYXMnaCRE2Xj2lDqpvRrAs
 YpEmSfujcV3B+RhzHdUVnOCnVQnEHBqKAyh4d5wCEhNKBA4UYlVIv4LFkZ6M7nlY2qqc
 894zSyPT0gKqENWZwF+K7tSx/Eq5JW/GCBtyN9BQW8/BOcYqaLbB2YnuZrguPCnXrHMY 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b5aw7hc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 09:04:12 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10RE3s3j087542;
        Wed, 27 Jan 2021 09:04:10 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b5aw7ha2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 09:04:10 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RE1aQo010034;
        Wed, 27 Jan 2021 14:04:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 368be820qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 14:04:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RE3uca13238774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 14:03:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C1B911C052;
        Wed, 27 Jan 2021 14:04:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B24D11C050;
        Wed, 27 Jan 2021 14:04:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.15.120])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jan 2021 14:03:59 +0000 (GMT)
Message-ID: <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
Date:   Wed, 27 Jan 2021 09:03:59 -0500
In-Reply-To: <3063834.1611747971@warthog.procyon.org.uk>
References: <YAjMm9Gq/FFOzQYG@kernel.org>
         <E090372C-06A3-4991-8FC3-F06A0DA60729@oracle.com>
         <20200916004927.64276-1-eric.snowberg@oracle.com>
         <1360578.1607593748@warthog.procyon.org.uk>
         <2442460.1610463459@warthog.procyon.org.uk>
         <X/9a8naM8p4tT5sO@linux.intel.com>
         <A05E3573-B1AF-474B-94A5-779E69E5880A@oracle.com>
         <YAFdNiYZSWpB9vOw@kernel.org>
         <CFBF6AEC-2832-44F7-9D7F-F20489498C33@oracle.com>
         <YAgTawk3EENF/P6j@kernel.org>
         <D9F5E0BD-E2FC-428F-91B3-35D2750493A0@oracle.com>
         <3063834.1611747971@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_05:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing linux-integrity]

On Wed, 2021-01-27 at 11:46 +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > > I suppose a user space tool could be created. But wouldn’t what is
> > > currently done in the kernel in this area need to be removed?
> > 
> > Right. I don't think this was a great idea in the first place to
> > do to the kernel but since it exists, I guess the patch does make
> > sense.
> 
> This information needs to be loaded from the UEFI tables before the system
> starts loading any kernel modules or running any programs (if we do
> verification of such, which I think IMA can do).

There needs to a clear distinction between the pre-boot and post-boot
keys.  UEFI has its own trust model, which should be limited to UEFI. 
The .platform keyring was upstreamed and limited to verifying the kexec
kernel image.   Any other usage of the .platform keyring keys is
abusing its intended purpose.

The cover letter says,   "Anytime the .platform keyring is used, the
keys in the .blacklist keyring are referenced, if a matching key is
found, the key will be rejected."   I don't have a problem with loading
the UEFI X509 dbx entries as long as its usage is limited to verifying
the kexec kernel image.

Mimi

