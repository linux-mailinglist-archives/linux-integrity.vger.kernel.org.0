Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A2428CA7
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Oct 2021 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhJKMKS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Oct 2021 08:10:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236510AbhJKMKQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Oct 2021 08:10:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BA6FKs004788;
        Mon, 11 Oct 2021 08:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VZZvdjRrDQF3hlCRqBFzF5D63+t1S1W+3AmXe0vsh5k=;
 b=m5WCBLwT80IVhEhD1gM5CRz/89Hrp7uiIFvjGdgnRWZL8ESeHCzFt5rnMpszwifIWiVa
 99cvZ1fnw+qxFkcUWUkYHEYMQmng9/HcRIvkuESehBoKJljAEPCTyWcal6UPvhXhQu9p
 dKukcZ/YicDDWKIsen8M3+OyqpjiDDjPSy7trKJOsAo8IGRksxwNOSCEv//Z+YyaEzbY
 DbIkyPkg9lsAlumG2xWaQ0Li5ceM3roFfq7pbCJYdsjP0pbe5q8isKxGovNaNGGe50Fx
 ERqsWN3VdJi2OuVhtD5R4KBfMHq78pfmll8S6tkNXr3/kC7oBZTajwZEeK6LAdyCD620 zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmfsu7bwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 08:08:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19BBDRTS014711;
        Mon, 11 Oct 2021 08:08:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmfsu7bvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 08:08:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19BC7Jr0016687;
        Mon, 11 Oct 2021 12:08:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9nfcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 12:08:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19BC840F61473164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:08:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 266C5AE061;
        Mon, 11 Oct 2021 12:08:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0740EAE057;
        Mon, 11 Oct 2021 12:08:03 +0000 (GMT)
Received: from sig-9-65-79-79.ibm.com (unknown [9.65.79.79])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 12:08:02 +0000 (GMT)
Message-ID: <685eb07ebb22de45a0b15c82fe7b8d56431269ce.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] IMA checkpatch fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com
Date:   Mon, 11 Oct 2021 08:08:01 -0400
In-Reply-To: <20211008091430.22392-1-pvorel@suse.cz>
References: <20211008091430.22392-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qeAKboljqt0ml8yH-B988w0FyhuTcYFk
X-Proofpoint-ORIG-GUID: 9W9iaNlXuplW4KH7F7UPbqjxhb2Qb4O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=957 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr, Alex,

On Fri, 2021-10-08 at 11:14 +0200, Petr Vorel wrote:
> Hi,
> 
> very minor checkpatch fixes based on [v3,2/2] ima: add gid support patchset [1].

These and the original gid patch set are now queued in next-integrity-
testing.

thanks,

Mimi

