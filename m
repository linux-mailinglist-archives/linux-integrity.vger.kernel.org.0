Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7638EFF
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfFGP0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 11:26:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729877AbfFGP0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 11:26:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57FN0Fj016180
        for <linux-integrity@vger.kernel.org>; Fri, 7 Jun 2019 11:26:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2syth4g512-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 11:26:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Jun 2019 16:26:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 16:26:09 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x57FQ89940304766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 15:26:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B397A4062;
        Fri,  7 Jun 2019 15:26:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 066E1A405B;
        Fri,  7 Jun 2019 15:26:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.48])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 15:26:06 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] ima: add enforce-evm and log-evm modes to
 strictly check EVM status
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        dmitry.kasatkin@huawei.com, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Fri, 07 Jun 2019 11:25:56 -0400
In-Reply-To: <773c3301-7861-f28b-813a-1f2ff657bae8@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
         <20190606112620.26488-3-roberto.sassu@huawei.com>
         <1559917462.4278.253.camel@linux.ibm.com>
         <93459fe8-f9b6-fe45-1ca7-2efb8854dc8b@huawei.com>
         <1559920112.4278.264.camel@linux.ibm.com>
         <773c3301-7861-f28b-813a-1f2ff657bae8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060715-0020-0000-0000-000003481BC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060715-0021-0000-0000-0000219B3678
Message-Id: <1559921156.4278.276.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-07 at 17:14 +0200, Roberto Sassu wrote:
> On 6/7/2019 5:08 PM, Mimi Zohar wrote:
> > On Fri, 2019-06-07 at 16:40 +0200, Roberto Sassu wrote:
> >>> On Thu, 2019-06-06 at 13:26 +0200, Roberto Sassu wrote:
> > 
> >>>> Although this choice appears legitimate, it might not be suitable for
> >>>> hardened systems, where the administrator expects that access is denied if
> >>>> there is any error. An attacker could intentionally delete the EVM keys
> >>>> from the system and set the file digest in security.ima to the actual file
> >>>> digest so that the final appraisal status is INTEGRITY_PASS.
> >>>
> >>> Assuming that the EVM HMAC key is stored in the initramfs, not on some
> >>> other file system, and the initramfs is signed, INTEGRITY_UNKNOWN
> >>> would be limited to the rootfs filesystem.
> >>
> >> There is another issue. The HMAC key, like the public keys, should be
> >> loaded when appraisal is disabled. This means that we have to create a
> >> trusted key at early boot and defer the unsealing.
> > 
> > There is no need for IMA to appraise the public key file signature,
> > since the certificate is signed by a key on the builtin/secondary
> > trusted keyring.  With CONFIG_IMA_LOAD_X509 enabled, the public key
> > can be loaded onto the IMA keyring with IMA-appraisal enabled, but
> > without verifying the file signature.
> 
> Yes, but access to the files containing the master key and the EVM key
> is denied if appraisal is enabled.

This is a key loading ordering issue.  Assuming you load the IMA key
first, you should be able to verify the master and EVM keys.

Mimi

