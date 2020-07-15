Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2622018B
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 02:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgGOA6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 20:58:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbgGOA6Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 20:58:25 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F0cjxN017275;
        Tue, 14 Jul 2020 20:58:19 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329d9hj6n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 20:58:19 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06F0u0Z3009189;
        Wed, 15 Jul 2020 00:58:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 327527hxuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 00:58:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06F0wFUI983404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 00:58:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B04C11C04C;
        Wed, 15 Jul 2020 00:58:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED7C11C050;
        Wed, 15 Jul 2020 00:58:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 00:58:13 +0000 (GMT)
Message-ID: <1594774692.12900.220.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Tue, 14 Jul 2020 20:58:12 -0400
In-Reply-To: <20200702153545.3126-2-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
         <20200702153545.3126-2-t-josne@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_09:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=965
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140169
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> Add a testcase that verifies that kexec correctly logs the
> kernel command line to the IMA buffer and that the command
> line is then correctly measured.
> 
> This test must be run standalone, since it runs kexec
> multiple times (and therefore reboots several times).

Verifying the kexec boot command line doesn't require rebooting.  Just
loading the kexec kernel image should be enough (kexec -s -l).
 Verifying that the measurement list, including the kexec boot command
line, is carried across kexec could be a separate test.

Mimi
