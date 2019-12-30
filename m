Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D812D25C
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL3RBu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 12:01:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbfL3RBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 12:01:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBUGxe71186171
        for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2019 12:01:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x6n491r3m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2019 12:01:48 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Dec 2019 17:01:46 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Dec 2019 17:01:43 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBUH1hB123986282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Dec 2019 17:01:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D566842041;
        Mon, 30 Dec 2019 17:01:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C11842052;
        Mon, 30 Dec 2019 17:01:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Dec 2019 17:01:41 +0000 (GMT)
Subject: Re: [IMA] 11b771ffff:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     kernel test robot <rong.a.chen@intel.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, lkp@lists.01.org
Date:   Mon, 30 Dec 2019 12:01:41 -0500
In-Reply-To: <20191227142335.GE2760@shao2-debian>
References: <20191227142335.GE2760@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19123017-0028-0000-0000-000003CCF55E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19123017-0029-0000-0000-000024905DBD
Message-Id: <1577725301.5874.32.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-30_05:2019-12-27,2019-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=645 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912300154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2019-12-27 at 22:23 +0800, kernel test robot wrote:
> [  333.455345] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
> [  333.457243] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12395, name: userfaultfd
> [  333.458888] CPU: 1 PID: 12395 Comm: userfaultfd Not tainted 5.5.0-rc1-00011-g11b771ffff8fc #1
> [  333.461096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  333.463893] Call Trace:
> [  333.465287]  <IRQ>
> [  333.466351]  dump_stack+0x66/0x8b
> [  333.467346]  ___might_sleep+0x102/0x120
> [  333.468385]  mutex_lock+0x1c/0x40
> [  333.469421]  ima_process_queued_keys+0x24/0x110
> [  333.470529]  ? ima_process_queued_keys+0x110/0x110
> [  333.471656]  call_timer_fn+0x2d/0x140
> [  333.472707]  run_timer_softirq+0x46f/0x4b0
> [  333.473752]  ? enqueue_hrtimer+0x39/0xa0
> [  333.474780]  __do_softirq+0xe3/0x2f8
> [  333.475768]  irq_exit+0xd5/0xe0
> [  333.476738]  smp_apic_timer_interrupt+0x74/0x140
> [  333.477834]  apic_timer_interrupt+0xf/0x20
> [  333.478858]  </IRQ>

I think this is an instance where defining timer_expired as atomic and
then testing it using atomic_dec_and_test() would help.  Either the
queued keys would be deleted in ima_timer_handler() or measured in
ima_process_queued_keys().

Mimi

