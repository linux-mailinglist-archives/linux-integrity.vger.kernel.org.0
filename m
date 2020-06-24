Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77CA207F36
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgFXWOS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 18:14:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44542 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbgFXWOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 18:14:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OM183w115381
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 18:14:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwys10rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 18:14:16 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OM2JAk120073
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 18:14:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwys10r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 18:14:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OMCVeR008232;
        Wed, 24 Jun 2020 22:14:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjh28v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 22:14:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OMECq57406014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 22:14:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 005254C052;
        Wed, 24 Jun 2020 22:14:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1064C04A;
        Wed, 24 Jun 2020 22:14:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jun 2020 22:14:08 +0000 (GMT)
Message-ID: <1593036848.27152.211.camel@linux.ibm.com>
Subject: Re: [PATCH] ima-evm-utils: skip test for discrete TPM 1.2 and
 exec'd as normal user
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 24 Jun 2020 18:14:08 -0400
In-Reply-To: <20200624212420.3300-1-bmeneg@redhat.com>
References: <20200624212420.3300-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_16:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Wed, 2020-06-24 at 18:24 -0300, Bruno Meneguele wrote:
> boot_aggregate test make use of a software TPM 2.0 in case it doesn't find
> any /dev/tpm0 in the system or if the test is ran as a normal user. However,
> when the system has a discrete TPM 1.2 and the user runs the test with a
> non-root user evmctl fails to return the software TPM 2.0 boot aggregate
> value because it tries to access the sysfs PCRs file and, consequently, the
> test fails.
> 
> Supporting a software TPM 1.2 involved some more work and new dependency in
> other programs to extend the PCRs accordingly. Because of that, just drop
> support for this scenario for now.

The problem is that the TPM 1.2 PCRs are visible to userspace.
 Insteaad of reading the software TPM PCRs, it's reading the discrete
TPM 1.2 PCRs.  I would drop this paragraph and simply say the sample
TPM 2.0 log test is not supported on systems with a discrete TPM 1.2.

The patch itself is fine.

thanks,

Mimi
