Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF342938
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439684AbfFLOav (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 10:30:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437757AbfFLOav (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 10:30:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CEPE1j014185
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 10:30:50 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t32wxrutg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 10:30:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 15:30:47 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 15:30:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CEUjHh17564124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 14:30:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27EBA5205A;
        Wed, 12 Jun 2019 14:30:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7151752059;
        Wed, 12 Jun 2019 14:30:44 +0000 (GMT)
Subject: Re: [PATCH v3] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY
 API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 12 Jun 2019 10:30:33 -0400
In-Reply-To: <1559086262.4139.75.camel@linux.ibm.com>
References: <20190323025633.26541-1-vt@altlinux.org>
         <1559069833.4139.25.camel@linux.ibm.com>
         <20190528224657.r6muelxxhjdgcyji@altlinux.org>
         <1559086262.4139.75.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061214-0016-0000-0000-0000028877BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061214-0017-0000-0000-000032E5ADF4
Message-Id: <1560349833.4578.25.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=847 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120097
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Tue, 2019-05-28 at 19:31 -0400, Mimi Zohar wrote:
> On Wed, 2019-05-29 at 01:46 +0300, Vitaly Chikunov wrote:


> > I already tried to leave RSA handling as is for v1 signatures, because
> > they are RSA specific anyway.
> > 
> > Also, I tried to leave most (external) API the same, except
> > calc_keyid_v2 which now gets EVP_PKEY instead of RSA. Internally,
> > find_keyid now returns EVP_PKEY too.
> > 
> > read_pub_key now extracts RSA from EVP_PKEY from read_pub_pkey.
> 
> Right.  So why couldn't the first patch define read_pub_pkey(), but
> only call it from read_pub_key().  Then subsequent patches could call
> read_pub_pkey() directly.
> 
> > 
> > And calc_keyid_v2 now works internally slightly differently (and
> > generally) to handle all possible key types.
> > 
> > Also, I run some tests with ASan.

Releasing a new version of ima-evm-utils is way over due.  I'd really
like to release a new version of ima-evm-utils soon.  Are you planning
on breaking this patch up?

Mimi

