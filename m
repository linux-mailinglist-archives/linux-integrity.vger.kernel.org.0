Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B83C1622
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhGHPkV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 11:40:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15574 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbhGHPkV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 11:40:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168FZ0KS138864;
        Thu, 8 Jul 2021 11:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=a7+Qbg+56tf1vtzIRwdO5dyIp/a7GWHrUicPO+L7dPQ=;
 b=e2hHqGHJfmdRVTwUSwqKE6Fk0FSP+T5Wv5SUm02Ae2uU35/3zYPXurXknIgwvOoZawFH
 nL5/WAX37H494R9NVFQ/Ttl0M0SSy9TM4GZFdjVOaEyNW3nctWo0BF8vNX7Krj7BVUj0
 fXOINWzpO5blF+iIOHXtj5b5VG6VOqA9B2hsCTMY5zy6SO+Ng8jgfHP5+DyftsAO456v
 vdm7udFBeFDKzLOXkuAqtJ7kBm4P4Uq44cmUgekj4rYWVLjQZZjUzJWvWRs7ag7FSt3V
 lqp18WXQHsNRELjJpxM5uVpFggurw1jmFYnBlM48pg+uMCrEl609WJPzZZDWBsI03uAp 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p0hqh37q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 11:37:37 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 168FZN8M140342;
        Thu, 8 Jul 2021 11:37:37 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p0hqh372-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 11:37:36 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168FbZvh019064;
        Thu, 8 Jul 2021 15:37:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 39jfh897gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 15:37:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168FbWmF21430696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 15:37:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFEC2AE055;
        Thu,  8 Jul 2021 15:37:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13E06AE045;
        Thu,  8 Jul 2021 15:37:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.92.57])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 15:37:31 +0000 (GMT)
Message-ID: <21f4d34f89ac6cb39b7b9e331aad35ef70f43299.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/3] ima-evm-utils: Add --keyid option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 08 Jul 2021 11:37:31 -0400
In-Reply-To: <20210706211322.wmw5w3loysyvbryl@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
         <7d201d4724e7399f87c0cc2f7291cfd13351d156.camel@linux.ibm.com>
         <20210706211322.wmw5w3loysyvbryl@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TDfko5kXcyG9hmNvs7ohL-ZkLdt-rSJt
X-Proofpoint-ORIG-GUID: W1UMVM4Oztyny-FQjfRYCqAfikEsfmSC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_09:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-07 at 00:13 +0300, Vitaly Chikunov wrote:
> 
> > I haven't started using Github actions.
> 
> Will you create repo there?

Done.

thanks,

Mimi

