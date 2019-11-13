Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DECFB406
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfKMPqb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 10:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbfKMPqa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 10:46:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADFfVZp117728
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 10:46:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8krcaky5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 10:46:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Nov 2019 15:46:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 15:46:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADFkKZ738404258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 15:46:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 931F9AE057;
        Wed, 13 Nov 2019 15:46:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C70DAE04D;
        Wed, 13 Nov 2019 15:46:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.227.104])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 15:46:19 +0000 (GMT)
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
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>
Date:   Wed, 13 Nov 2019 10:46:18 -0500
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111315-0028-0000-0000-000003B69508
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111315-0029-0000-0000-000024799DE0
Message-Id: <1573659978.17949.83.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 01:22 +0000, Zhao, Shirley wrote:
> Hi, all,
> 
> This is Shirley from Intel. I have one question about trusted key of
> keyring in kernel. Please help.
> 
> According the to description in https://github.com/torvalds/linux/bl
> ob/master/Documentation/security/keys/trusted-encrypted.rst.
> Trusted key will be saved in TPM with PCR policy protected.

"Trusted Keys use a TPM both to generate and to seal the keys. Keys
are sealed under a 2048 bit RSA key in the TPM, ..."

Trusted keys are not TPM keys.  They are not stored in the TPM.

> 
> Then, I running the following command to create a trusted key.
> keyctl add trusted test_trusted "new 32 keyhandle=0x81000001" @u
> 
> I also tried the following command, it can add one trusted key, too.
> keyctl add trusted test_trusted "new 32 keyhandle=0x81000001
> pcrinfo=`cat pcr7.blob`" @u
> 
> But after reboot, this key will be removed.
> I need to re-added during boot.

Right, they need to be re-loaded on boot.  Refer to the dracut
module /modules.d/97masterkey for loading a trusted key during boot.

> 
> Then the question is since this key is saved in TPM, how to get it
> back from TPM?

Trusted keys are not stored in the TPM.  Refer to the ima-evm-utils
README for examples of creating a trusted key (kmk) and an encrypted
key (evm-key).

> 
> From the document, I need to use "keyctl pipe" to save the key into
> a blob, then load it.
> But the blob contend key text, and this is a file on hard disk, it
> is not safe to protect the key.
> 
> So what can TPM do here?

The hex ascii encoded trusted key is sealed under the TPM SRK.

Mimi

