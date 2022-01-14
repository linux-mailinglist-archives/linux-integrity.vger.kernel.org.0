Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAA48E20A
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 02:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiANBL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 20:11:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235827AbiANBL7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 20:11:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E0vL1Q027374;
        Fri, 14 Jan 2022 01:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qHwD/kwlwg01gOkedqDILKViXCu67l4yT86yUIa1IY4=;
 b=Kbd1CKboweHvz5I9SMl5yLwHLp0oDiqJbMyGsNVAwnPc5zRN8gDOmwXNSttX8v17Oz0M
 pAnpFNEWK57BeTFO9c+RVt6owIotwjkzbC+YQuuq2g5saSG+1KRlsuls7J8bge07mkMg
 Js3z4HiKq/aZLYZyBVqHamaMpDRu6+Gqm3vkHMyITMYZMwLQxV660QS+K4mEaaKnCDnk
 eZwNVU5Ve20Gngy9k5iWs8nmIP6YMj8GbfV6u6snn3oIy3bVsecHEndgn0P+xfLBJlNR
 Yv3VMRuWJPWTU9tIv4lA7vJENsppGA1PUUc071aHDgLSYd1MPFdt9ynxLugJTCBMZEiI MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djy3br84r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:11:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20E18LR5006614;
        Fri, 14 Jan 2022 01:11:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djy3br84a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:11:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20E16hWM018656;
        Fri, 14 Jan 2022 01:11:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjt6ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:11:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20E1BliF37945632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 01:11:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 632B4A4053;
        Fri, 14 Jan 2022 01:11:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A854A4040;
        Fri, 14 Jan 2022 01:11:46 +0000 (GMT)
Received: from sig-9-65-76-253.ibm.com (unknown [9.65.76.253])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jan 2022 01:11:46 +0000 (GMT)
Message-ID: <8f0d69607590096c1be5d7c4c2a3ece316100ca0.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ima_measurements.sh: Use /proc/uptime instead of
 date
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     linux-integrity@vger.kernel.org, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, Cyril Hrubis <chrubis@suse.cz>
Date:   Thu, 13 Jan 2022 20:11:45 -0500
In-Reply-To: <20220112150123.13768-1-pvorel@suse.cz>
References: <20220112150123.13768-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Pam8IEKUYjWQZ3Ff0WX_8wszZlpmsbh
X-Proofpoint-GUID: xHSo5A0ibk7Xv9Nw3efWkOTfbFx-XmKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-12 at 16:01 +0100, Petr Vorel wrote:
> It fixes more iterations (e.g. -i2) which is more precise.
> date +%s could be used, but it's better use procfs file instead
> requiring binary.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

