Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4D14A9D7
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 19:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0Sf6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 13:35:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0Sf5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 13:35:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RIYNNf023083
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 13:35:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrjr4k1ha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 13:35:56 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 18:35:54 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 18:35:51 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RIZo8a43057508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 18:35:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 068CFAE051;
        Mon, 27 Jan 2020 18:35:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53ABEAE058;
        Mon, 27 Jan 2020 18:35:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 18:35:49 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jan 2020 13:35:48 -0500
In-Reply-To: <1580148975.5088.38.camel@linux.ibm.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <ca189378a5f841d0ba111c6405079569@huawei.com>
         <1580148975.5088.38.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012718-0012-0000-0000-00000381286D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012718-0013-0000-0000-000021BD795E
Message-Id: <1580150148.5088.41.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_06:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-27 at 13:16 -0500, Mimi Zohar wrote:
> On Mon, 2020-01-27 at 17:38 +0000, Roberto Sassu wrote:
> > > -----Original Message-----
> > > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > > Sent: Monday, January 27, 2020 5:02 PM
> > > To: linux-integrity@vger.kernel.org
> > > Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> > > <James.Bottomley@HansenPartnership.com>; linux-
> > > kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> > > Subject: [PATCH 1/2] ima: use the IMA configured hash algo to calculate the
> > > boot aggregate
> > 
> > Hi Mimi
> > 
> > I did a similar change (patch 8/8) in the patch set I just sent. The patch is simpler,
> > as it reuses the data structures I introduced in the previous patches. Let me know
> > if I can keep this part in my patch set or I should remove it.
> 
> Only 2/2 "ima: support calculating the boot_aggregate based on
> different TPM banks" is really needed to address Jerry's bug report.
>  Let's review your patch set before making any decisions about 1/2
> "ima: use the IMA configured hash algo to calculate the boot
> aggregate".

To be more precise, we need to be able to backport the bug fix.  So
the change needs to be independent of anything you're defining now.
 Changes/improvements can be made on top of the bug fix.

thanks,

Mimi

