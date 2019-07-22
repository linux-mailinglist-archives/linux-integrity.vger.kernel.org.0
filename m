Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5DA70989
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfGVTQL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 15:16:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbfGVTQL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 15:16:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MJCe83085926
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 15:16:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2twhmqks62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 15:16:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 22 Jul 2019 20:16:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 20:16:07 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MJG6bW14221398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 19:16:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF9A4C046;
        Mon, 22 Jul 2019 19:16:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC5C84C04A;
        Mon, 22 Jul 2019 19:16:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.145])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 19:16:05 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Cc:     Kenneth Goldman <kgoldman@us.ibm.com>
Date:   Mon, 22 Jul 2019 15:15:55 -0400
In-Reply-To: <20190722185245.GB27614@glitch>
References: <1563802368-8460-1-git-send-email-zohar@linux.ibm.com>
         <20190722155835.yaxtxlse4nufmbxq@altlinux.org>
         <20190722185245.GB27614@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072219-4275-0000-0000-0000034FA2B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072219-4276-0000-0000-0000385FC548
Message-Id: <1563822955.14396.88.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220210
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Vitaly, Bruno,

On Mon, 2019-07-22 at 15:52 -0300, Bruno E. O. Meneguele wrote:
> On Mon, Jul 22, 2019 at 06:58:35PM +0300, Vitaly Chikunov wrote:
> > Mimi,
> > 
> > On Mon, Jul 22, 2019 at 09:32:48AM -0400, Mimi Zohar wrote:
> > > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > > application is required to read PCRs.
> > > 
> > > This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> > > tsspcrread is one application included in the ibmtss package.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you for reviewing this patch so quickly!  Your comments are much
appreciated and will be addressed in the version.

Mimi

