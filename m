Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A93B321A
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2019 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfIOUxY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Sep 2019 16:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfIOUxY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Sep 2019 16:53:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8FKqJro029340
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2019 16:53:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v1v600g7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2019 16:53:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 15 Sep 2019 21:53:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Sep 2019 21:53:18 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8FKrH4B42991634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 20:53:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8EDC11C052;
        Sun, 15 Sep 2019 20:53:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF5D11C050;
        Sun, 15 Sep 2019 20:53:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.212.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 15 Sep 2019 20:53:16 +0000 (GMT)
Subject: Re: KEYS-TRUSTED git
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, sumit.garg@linaro.org
Date:   Sun, 15 Sep 2019 16:53:16 -0400
In-Reply-To: <20190913133228.GE7412@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
         <1567952431.4614.140.camel@linux.ibm.com>
         <20190909165200.npxq3hkft4bddv6v@linux.intel.com>
         <1568049898.4614.349.camel@linux.ibm.com>
         <20190913133228.GE7412@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091520-0008-0000-0000-00000316821E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091520-0009-0000-0000-00004A34F900
Message-Id: <1568580796.5055.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909150229
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-13 at 14:32 +0100, Jarkko Sakkinen wrote:
> On Mon, Sep 09, 2019 at 01:24:58PM -0400, Mimi Zohar wrote:
> > On Mon, 2019-09-09 at 17:52 +0100, Jarkko Sakkinen wrote:
> > > On Sun, Sep 08, 2019 at 10:20:31AM -0400, Mimi Zohar wrote:
> > > > Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> > > > based keys.  Now would be a good time to set up at least a separate
> > > > branch or GIT repo.
> > > 
> > > I created a tree for trusted keys:
> > > 
> > > http://git.infradead.org/users/jjs/linux-trusted-keys.git
> > > 
> > > The remaining issue before I send a patch to update MAINTAINERS is whether
> > > the flow goes through David to Linus or directly to Linus.
> > 
> > David?
> 
> I think using tpmdd tree makes sense because there is so much
> correlation.

Yes, agreed.

Mimi

