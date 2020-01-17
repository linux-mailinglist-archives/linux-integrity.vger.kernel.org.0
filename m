Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BBE140259
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 04:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgAQDga (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 22:36:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbgAQDg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 22:36:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H3VuJT103774
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 22:36:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qqx814-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 22:36:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 17 Jan 2020 03:36:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 03:36:23 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00H3aNOo47644822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 03:36:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D89A405B;
        Fri, 17 Jan 2020 03:36:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 307F8A4054;
        Fri, 17 Jan 2020 03:36:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.212.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jan 2020 03:36:22 +0000 (GMT)
Subject: Re: [PATCH v2] IMA: pre-allocate buffer to hold keyrings string
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 22:36:21 -0500
In-Reply-To: <20200117021821.2566-1-nramas@linux.microsoft.com>
References: <20200117021821.2566-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011703-0012-0000-0000-0000037E17C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011703-0013-0000-0000-000021BA4D57
Message-Id: <1579232181.5125.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001170025
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-16 at 18:18 -0800, Lakshmi Ramasubramanian wrote:
> ima_match_keyring() is called while holding rcu read lock. Since this
> function executes in atomic context, it should not call any function
> that can sleep (such as kstrdup()).
> 
> This patch pre-allocates a buffer to hold the keyrings string read from
> the IMA policy and uses that to match the given keyring.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")

Thanks!  This patch is now queued in next-integrity-testing.

Mimi

