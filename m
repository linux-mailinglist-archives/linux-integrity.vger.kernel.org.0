Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267B2229EFB
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGVSKC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 14:10:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgGVSKB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 14:10:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MI3BvU158881;
        Wed, 22 Jul 2020 14:09:55 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vs4u1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 14:09:55 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MI7Dms030353;
        Wed, 22 Jul 2020 18:09:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgtqn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 18:09:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MI9pEW62259306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 18:09:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F089BAE057;
        Wed, 22 Jul 2020 18:09:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EE4EAE053;
        Wed, 22 Jul 2020 18:09:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.219.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 18:09:49 +0000 (GMT)
Message-ID: <1595441389.5211.1.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Wed, 22 Jul 2020 14:09:49 -0400
In-Reply-To: <20200722164040.23109-1-t-josne@linux.microsoft.com>
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_10:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
> IMA policy can be set to measure the command line passed in the kexec system call.
> There needs to be a test to validate this kexec command line measurement.
> 
> Add a testcase that verifies that the IMA subsystem has correctly
> measured the cmdline specified during a kexec.
> 
> Note that this test does not actually reboot.
> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>

Other than the patch not applying cleanly and leading blanks, 

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
