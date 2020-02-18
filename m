Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26116304E
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2020 20:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBRThz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 14:37:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgBRThy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 14:37:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IJajvG043776
        for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2020 14:37:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b576qbp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2020 14:37:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Feb 2020 19:37:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 19:37:47 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IJbkch43188450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 19:37:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1278552050;
        Tue, 18 Feb 2020 19:37:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.154.230])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA5985204F;
        Tue, 18 Feb 2020 19:37:44 +0000 (GMT)
Subject: Re: [PATCH v4 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 14:37:42 -0500
In-Reply-To: <857c8dc6-d09c-423e-c520-53bb85c6d46c@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
         <20200215014709.3006-2-tusharsu@linux.microsoft.com>
         <857c8dc6-d09c-423e-c520-53bb85c6d46c@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021819-0016-0000-0000-000002E80C3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021819-0017-0000-0000-0000334B21B2
Message-Id: <1582054662.5067.15.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_06:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=985 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-02-18 at 11:25 -0800, Tushar Sugandhi wrote:
> Hi Mimi,
> 
> On 2020-02-14 5:47 p.m., Tushar Sugandhi wrote:
> > The kbuild Makefile specifies object files for vmlinux in the $(obj-y)
> > lists. These lists depend on the kernel configuration[1].
> > 
> > The kbuild Makefile for IMA combines the object files for IMA into a
> > single object file namely ima.o. All the object files for IMA should be
> > combined into ima.o. But certain object files are being added to their
> > own $(obj-y). This results in the log messages from those modules getting
> > prefixed with their respective base file name, instead of "ima". This is
> > inconsistent with the log messages from the IMA modules that are combined
> > into ima.o.
> > 
> > This change fixes the above issue.
> > 
> > [1] Documentation\kbuild\makefiles.rst
> > 
> Is there any feedback on this patch description?
> I can address it in the next iteration.

No, it looks good to me.

Mimi

