Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2F2F4E51
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbhAMPRX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 10:17:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbhAMPRW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 10:17:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10DFCsJ0012977;
        Wed, 13 Jan 2021 10:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FFwSMGnjHPCEZG/p5ENas76+2RF2zeo2Gl3j/YpLT+Y=;
 b=NSIBCVXOq4h/cHxyOvxZIsuO9TCbF6bHQxYRc9mRiTDG5kBGfnP0pp/0KVzmzk5GSSyO
 kYh7tI2iOWFDLSTs7E9pvAVFu+twYhwGGmqY2dluZ6oXdzilslgROCfngE2iqoHmdeWM
 MPRIprntvp7G+LV4bwqbRVDBpAW0BdAKaAIBqnCnjgIMPwU2iVsiLk5ZCdOtGKn44pwW
 215HNO3bgleTanxUiomNC6TPA96Awhbwn2LBIDE7B4vJgnN9LbDVtwC3yVykkmNKQCwM
 R9ll3af3sV2ySLuIDzOoNaEXwIaAeRj/v0k1xYN7BU4YKK9fzhDrif4xwGQTM6b61DKM OQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3623a383bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 10:16:37 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10DF8FmV012643;
        Wed, 13 Jan 2021 15:16:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 35y448d6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 15:16:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10DFGSUo29950208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 15:16:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CACC6A4054;
        Wed, 13 Jan 2021 15:16:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11142A4066;
        Wed, 13 Jan 2021 15:16:31 +0000 (GMT)
Received: from sig-9-65-221-171.ibm.com (unknown [9.65.221.171])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jan 2021 15:16:30 +0000 (GMT)
Message-ID: <19977f2dbe6d25d7b38bdca4628bd1dded1142d9.camel@linux.ibm.com>
Subject: Re: [PATCH] [v2] evm: Fix memleak in init_desc
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 10:16:30 -0500
In-Reply-To: <20210110080253.32345-1-dinghao.liu@zju.edu.cn>
References: <20210110080253.32345-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_07:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=834
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Dinghao,

On Sun, 2021-01-10 at 16:02 +0800, Dinghao Liu wrote:
> When kmalloc() fails, tmp_tfm allocated by
> crypto_alloc_shash() has not been freed, which
> leads to memleak.
> 
> Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

This patch is now queued, with an updated patch description, in next-
integrity-testing.

thanks,

Mimi

