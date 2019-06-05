Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F953644C
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFETKu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 15:10:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfFETKt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 15:10:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55J75F0014367
        for <linux-integrity@vger.kernel.org>; Wed, 5 Jun 2019 15:10:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sxgbxrvr8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jun 2019 15:10:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 5 Jun 2019 20:10:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Jun 2019 20:10:43 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x55JAgFk45285468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jun 2019 19:10:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813DB11C05B;
        Wed,  5 Jun 2019 19:10:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CCA911C04C;
        Wed,  5 Jun 2019 19:10:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.201])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jun 2019 19:10:41 +0000 (GMT)
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 05 Jun 2019 15:10:30 -0400
In-Reply-To: <CACdnJuvva4n5dDfoUhzZ9RAxzR=Wou4SuLfe8DCGp4f53cXM3w@mail.gmail.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
         <1559691534.4278.14.camel@linux.ibm.com>
         <CACdnJuvva4n5dDfoUhzZ9RAxzR=Wou4SuLfe8DCGp4f53cXM3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060519-0016-0000-0000-000002856DCE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060519-0017-0000-0000-000032E28488
Message-Id: <1559761830.4278.30.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-05 at 11:12 -0700, Matthew Garrett wrote:
> On Tue, Jun 4, 2019 at 4:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Matthew, what is a "profile"?  Could we rename this patch to something
> > clearer?  Maybe something like "support for per policy rule template
> > formats"?
> 
> Sounds good to me. Could you also add an Inspired-By: Roberto Sassu
> <roberto.sassu@huawei.com> ?

Thanks, done.

Mimi

