Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F150F13DB32
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 14:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgAPNKm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 08:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgAPNKm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 08:10:42 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD6pdv066855
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 08:10:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhfer2rga-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 08:10:40 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 Jan 2020 13:10:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 13:10:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GDAYc411272198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 13:10:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FDA9AE057;
        Thu, 16 Jan 2020 13:10:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7BEAE06A;
        Thu, 16 Jan 2020 13:10:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.139.213])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 13:10:33 +0000 (GMT)
Subject: Re: [PATCH] IMA: inconsistent lock state in ima_process_queued_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dvyukov@google.com, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Date:   Thu, 16 Jan 2020 08:10:32 -0500
In-Reply-To: <20200116031342.3418-1-nramas@linux.microsoft.com>
References: <20200116031342.3418-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011613-0008-0000-0000-00000349E7B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011613-0009-0000-0000-00004A6A416F
Message-Id: <1579180232.5857.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=811 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160112
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-15 at 19:13 -0800, Lakshmi Ramasubramanian wrote:
> ima_queued_keys() is called from a non-interrupt context, but
> ima_process_queued_keys() may be called from both an interrupt
> context (ima_timer_handler) and non-interrupt context
> (ima_update_policy). Since the spinlock named ima_keys_lock is used
> in both ima_queued_keys() and ima_process_queued_keys(),
> irq version of the spinlock macros, spin_lock_irqsave() and
> spin_unlock_irqrestore(), should be used[1].
> 
> This patch fixes the "inconsistent lock state" issue caused by
> using the non-irq version of the spinlock macros in ima_queue_key()
> and ima_process_queued_keys().
> 
> [1] Documentation/locking/spinlocks.rst
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")
> Fixes: 9fb38e76b5f1 ("IMA: Define workqueue for early boot key measurements")

Thanks!  This patch is now queued in next-integrity-testing.

Mimi

