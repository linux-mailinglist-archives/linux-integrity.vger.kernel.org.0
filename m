Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C45245906
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Aug 2020 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHPSwv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 14:52:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgHPSwt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 14:52:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07GIVB7Y003745;
        Sun, 16 Aug 2020 14:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=d8NH751cU1XFjjb15Dgm0ZYiQKWof895v0Q4CaY6fFI=;
 b=PwpY8bT9fcVa1j3hTAXU8v33P/wiM+3RN645J7zMPaqRoWLObVLokZ2nKR9AyKsJ1BHm
 G5iIDm/fA6V2fjdRLaegfp8lS/upxzLyeXY/XJTyXX7BNeP3P1WzoTREbr3PXQfuU4zE
 2NXiG+/2TOLtLQrn7jeRz7qKYLVkxzOL1mwA3o8IBhNF2hS7NTsu4nE/oTcWvLqH/sWn
 t/4ppwKN7UtGVuN72jgomiWjP4AyrHjPKzR0jKSXUO4OvBtziYfxCWSGTX82HZX2KHqz
 5u7TUMvMErU6t0lsh416h9IMcWrW037KTrsH6ZWxm+yfxGzNYZH+ZwzmXwxka0TKxaEB aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7ngaw45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 14:52:44 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07GIqitE041580;
        Sun, 16 Aug 2020 14:52:44 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7ngaw3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 14:52:44 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07GIo9oa013320;
        Sun, 16 Aug 2020 18:52:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 32x7b80vae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 18:52:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07GIqe5a30867816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 18:52:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71BCB11C04C;
        Sun, 16 Aug 2020 18:52:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D39411C05B;
        Sun, 16 Aug 2020 18:52:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.65.247])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 18:52:38 +0000 (GMT)
Message-ID: <eef3e26154804f8568496b93df1a3bc59e091aa6.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 9/9] travis: Switch to docker based builds
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Sun, 16 Aug 2020 14:52:38 -0400
In-Reply-To: <20200813182532.6931-10-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
         <20200813182532.6931-10-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_07:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008160149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-13 at 20:25 +0200, Petr Vorel wrote:
> This requires to have distro specific install scripts and build.sh
> script.
> 
> For now ibmswtpm2 is compiled just for native builds (depends on gcc,
> compiled natively). libtmps/swtpm could be used.

Note:  in addition to installing a software TPM, the software TPM PCRs
needs to be initialized based on the TPM event log.  For now there is a
dependency on "tsseventextend" to walk the TPM event log extending the
software TPM PCRs in order to validate the "boot_aggregate".   Without
either a software TPM or "tsseventextend" installed, the
"boot_aggregate.test" will be skipped.

Mimi

