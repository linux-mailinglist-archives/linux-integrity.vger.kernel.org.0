Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB04F135BDA
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgAIOzI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 09:55:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbgAIOzH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 09:55:07 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009EqTQo115609
        for <linux-integrity@vger.kernel.org>; Thu, 9 Jan 2020 09:55:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe5tk1cfs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 09 Jan 2020 09:55:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 9 Jan 2020 14:55:04 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 14:55:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009EsChl45482274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 14:54:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF95CA4053;
        Thu,  9 Jan 2020 14:54:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F88BA404D;
        Thu,  9 Jan 2020 14:54:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.42])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 14:54:59 +0000 (GMT)
Subject: Re: [PATCH] ima: ima/lsm policy rule loading logic bug fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Date:   Thu, 09 Jan 2020 09:54:58 -0500
In-Reply-To: <20200109140821.17902-1-janne.karhunen@gmail.com>
References: <20200109140821.17902-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010914-0016-0000-0000-000002DBF132
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010914-0017-0000-0000-0000333E70A9
Message-Id: <1578581698.5147.51.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-09 at 16:08 +0200, Janne Karhunen wrote:
> Keep the ima policy rules around from the beginning even
> if they appear invalid at the time of loading, as they
> may become active after the lsm policy load. In other
> words, now the lsm and the ima can be initialized in any
> order and the handling logic is the same as with the lsm
> rule reload event.
> 
> Patch also fixes the rule re-use during the lsm policy
> reload and makes some prints a bit more human readable.

Thanks, Janne.  What do you think about adding a single sentence at
the end of this patch description?  Something along the lines of,
"With these changes, there no need to defer loading a custom IMA
policy, based on LSM rules, until after the LSM policy has been
initialized."

The line length, here, is a bit short.  According to section "14) the
canonical path format" of Documentation/process/submitting-
patches.rst, the body of the explanation shouldl be line wrapped at 75
columns.

> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>

Please include a "Fixes" tag as well.  Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

