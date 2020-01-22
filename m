Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453B4145919
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAVP43 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 10:56:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgAVP42 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 10:56:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MFmQ8e070712
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 10:56:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xnx9bqc1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 10:56:27 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Jan 2020 15:56:25 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Jan 2020 15:56:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00MFuKQE37159168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 15:56:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 792F252057;
        Wed, 22 Jan 2020 15:56:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.245])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B2D8552054;
        Wed, 22 Jan 2020 15:56:19 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Date:   Wed, 22 Jan 2020 10:56:19 -0500
In-Reply-To: <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012215-0016-0000-0000-000002DFBE34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012215-0017-0000-0000-000033426A86
Message-Id: <1579708579.5182.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Janne,

On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> >
> > Some systems can end up carrying lots of entries in the ima
> > measurement list. Since every entry is using a bit of kernel
> > memory, allow the sysadmin to export the measurement list to
> > the filesystem to free up some memory.
> 
> Hopefully this addressed comments from everyone. The flush event can
> now be triggered by the admin anytime and unique file names can be
> used for each flush (log.1, log.2, ...) etc, so getting to the correct
> item should be easy.
> 
> While it can now be argued that since this is an admin-driven event,
> kernel does not need to write the file. However, the intention is to
> bring out a second patch a bit later that adds a variable to define
> the max number of entries to be kept in the kernel memory and
> workqueue based automatic flushing. In those cases the kernel has to
> be able to write the file without any help from the admin..

I don't think it is common, and probably not acceptable, for the
kernel to open a file for writing.
 
As exporting the binary measurement list should be the equivalent of
displaying the binary measurement list and redirecting the output to a
file, the same mechanism used for displaying the binary measurement
list should be re-used for exporting it.  Just as carrying the
measurement list across kexec re-uses the same method.

Mimi

