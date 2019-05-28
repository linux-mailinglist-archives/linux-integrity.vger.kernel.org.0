Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1B2D26A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2019 01:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfE1XbW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 19:31:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbfE1XbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 19:31:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SNMPWK003514
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 19:31:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ssb3001xx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 19:31:20 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 29 May 2019 00:31:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 May 2019 00:31:15 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SNVEaw55312448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 23:31:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B984A405F;
        Tue, 28 May 2019 23:31:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 960C3A4054;
        Tue, 28 May 2019 23:31:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.111.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 May 2019 23:31:13 +0000 (GMT)
Subject: Re: [PATCH v3] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY
 API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 28 May 2019 19:31:02 -0400
In-Reply-To: <20190528224657.r6muelxxhjdgcyji@altlinux.org>
References: <20190323025633.26541-1-vt@altlinux.org>
         <1559069833.4139.25.camel@linux.ibm.com>
         <20190528224657.r6muelxxhjdgcyji@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052823-0008-0000-0000-000002EB5D49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052823-0009-0000-0000-000022582BD8
Message-Id: <1559086262.4139.75.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-29 at 01:46 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, May 28, 2019 at 02:57:13PM -0400, Mimi Zohar wrote:
> > On Sat, 2019-03-23 at 05:56 +0300, Vitaly Chikunov wrote:
> > > Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> > > This enables more signatures to work out of the box.
> > > 
> > > Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> > > is doing proper PKCS1 padding automatically (tested to be compatible
> > > with previous version, except for MD4). This also fixes bug with MD4
> > > which produced wrong signature because of absence of the appropriate
> > > RSA_ASN1_template.
> > 
> > Is there any way of breaking this patch up to simplify review?
> 
> Hm. The main change is to replace key type from RSA with more abstract
> EVP_PKEY. All other changes are a consequence of it.

Yes, I understand. 

> 
> And because keys are now EVP_PKEY the templates are removed too, now
> that we are not dealing with keys on the too low level anymore.

There's no reason that removing RSA_ASN1_templates[] needs to be in
the same patch as the pkey change, nor does the MAX_SIGNATURE_SIZE
changes in sign_evm().

> 
> I already tried to leave RSA handling as is for v1 signatures, because
> they are RSA specific anyway.
> 
> Also, I tried to leave most (external) API the same, except
> calc_keyid_v2 which now gets EVP_PKEY instead of RSA. Internally,
> find_keyid now returns EVP_PKEY too.
> 
> read_pub_key now extracts RSA from EVP_PKEY from read_pub_pkey.

Right.  So why couldn't the first patch define read_pub_pkey(), but
only call it from read_pub_key().  Then subsequent patches could call
read_pub_pkey() directly.

Mimi

> 
> And calc_keyid_v2 now works internally slightly differently (and
> generally) to handle all possible key types.
> 
> Also, I run some tests with ASan.
> Thanks,

