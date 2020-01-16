Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9B13F306
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgAPSjW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 13:39:22 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:52884 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388498AbgAPSjW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 13:39:22 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GIXs3f027841
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 18:39:21 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 2xjrenbjj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 18:39:21 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9B2EA4F
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 18:39:20 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E04574E
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 18:39:19 +0000 (UTC)
Date:   Fri, 17 Jan 2020 02:39:18 +0800
From:   Clay Chang <clayc@hpe.com>
To:     linux-integrity@vger.kernel.org
Subject: Question on signing the IMA signing key for kernel trusted keyrings?
Message-ID: <20200116183918.GA14177@blofly.tw.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=569 suspectscore=1
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001160147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

We know that IMA or EVM signing key must be signed by the .builtin_trusted_keys.
In the .builtin_trusted_keys keyring of a fresh CentOS, for example,
there are public keys created by CentOS. And the private key counterparts
were not available publicly. So I think there is technically no way for
others to sign the IMA or EVM key by the private keys of those CA.

Is there a possibility of getting the IMA or EVM signing keys signed
(probably by the public key in .builtin_trusted_keys) without rolling own
CA and re-gen the kernel?

Thanks,
Clay
