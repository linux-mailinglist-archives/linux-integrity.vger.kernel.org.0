Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE96B19BFF8
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgDBLOV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 07:14:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728803AbgDBLOV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 07:14:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032B43kY039370
        for <linux-integrity@vger.kernel.org>; Thu, 2 Apr 2020 07:14:20 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304g87av41-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Apr 2020 07:14:20 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 Apr 2020 12:14:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Apr 2020 12:14:15 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032BEGpx50528300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 11:14:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4373252054;
        Thu,  2 Apr 2020 11:14:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.150])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A63985205A;
        Thu,  2 Apr 2020 11:14:15 +0000 (GMT)
Subject: Re: [PATCH v8 2/2] ima-evm-utils: Add sign/verify tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 02 Apr 2020 07:14:15 -0400
In-Reply-To: <20200402071907.gyhm7gtg3kjjom4c@altlinux.org>
References: <20200327042515.22315-1-vt@altlinux.org>
         <20200327042515.22315-3-vt@altlinux.org>
         <1585764055.5188.652.camel@linux.ibm.com>
         <20200402071907.gyhm7gtg3kjjom4c@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040211-0028-0000-0000-000003F099A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040211-0029-0000-0000-000024B62345
Message-Id: <1585826055.5188.731.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_01:2020-03-31,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020096
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-04-02 at 10:19 +0300, Vitaly Chikunov wrote:
> > > +
> > > +  # Test --portable
> > > +  expect_pass check_sign OPTS="$OPTS --portable" PREF=0x05
> > > +  # Cannot be verified
> > 
> > True, evmctl does not support verifying portable signatures, but it
> > should be possible not only locally, but remotely to verify a portable
> > signature.  That's the whole point of having portable EVM signatures.
> >  The comment is a bit misleading and could say something to that
> > effect - "todo: add support for evmctl portable signature
> > verification".
> 
> Well, tests are not right place to note todos for other code.
> This todo would look like we need to add test case to the test, like
> test is missing something. While now it says that it impossible to test.
> 
> I will change text to something like "Cannot be verified for now, until
> that support is added to evmctl".

Thanks.

While you're updating the "sign_verify.test", could you expand this
comment a bit?  Referencing an example would help.

# Fix keyid in the prefix.
  if [[ $PREF =~ K ]]; then
    keyid=$(_keyid $KEY)

thanks,

Mimi

