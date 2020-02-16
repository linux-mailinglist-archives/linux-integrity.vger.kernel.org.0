Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7888416040E
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Feb 2020 13:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBPMkt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Feb 2020 07:40:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728054AbgBPMkt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Feb 2020 07:40:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01GCXj6s132851
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:40:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cu0p7qa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:40:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 16 Feb 2020 12:40:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Feb 2020 12:40:43 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01GCeg5n50987206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Feb 2020 12:40:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2959BAE053;
        Sun, 16 Feb 2020 12:40:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB468AE051;
        Sun, 16 Feb 2020 12:40:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.53])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Feb 2020 12:40:40 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] IMA: improve log messages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Feb 2020 07:40:40 -0500
In-Reply-To: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021612-0012-0000-0000-000003874F80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021612-0013-0000-0000-000021C3D9E3
Message-Id: <1581856840.8515.168.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-16_02:2020-02-14,2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxlogscore=938 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002160115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 17:47 -0800, Tushar Sugandhi wrote:
> The log messages from IMA subsystem should be consistent for better
> diagnosability and discoverability.

The change isn't limited to IMA.  I would change "IMA" to "integrity"
in the Subject line and in this patch description.

> This patch set improves the logging by removing duplicate log formatting
> macros, adding a consistent prefix to the log messages, and adding new 
> log messages where necessary.

Much better!

thanks,

Mimi

