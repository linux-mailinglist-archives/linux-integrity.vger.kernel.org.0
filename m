Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72845358B22
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhDHRPl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 13:15:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhDHRPj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 13:15:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138H4iQb020637;
        Thu, 8 Apr 2021 13:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xncVlsPvIAlSyI88tSUekwLpDqYeSKU/cUFZkrobCQE=;
 b=LyR3qNZ0n2KItuVSZHMl0aVkc63mKz+Ilsi+ORvLDXh0TQr9QoV/eTmyHKykGJfw8jFy
 m34fuM2wv4EZi8Yp9BFQ9Mwx8aj4rY8pXwmydGib4YRqcz7jD5+J3r7hQJdd47zXIvpR
 IgiYGQyYXQb3TeW48imrAIQ/wSaIxCnTGKP2KMRUTDvGotv1uyChFWjBmxqQ79SChN5Y
 hN5XmYRI86kEiTVpPgkve+p3HEnItcwHXSxztEX/eZOmUgZXQgEIkYgUSOD/vmk1UGSb
 YwKIOIJ3eB+OYMbIC9dC6wRHIRWyA+nWm3zmlXaItWTYNDrShdmGwo3nZBtW2aGq5asj BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvm1jrj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 13:15:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138H4oBV021108;
        Thu, 8 Apr 2021 13:15:24 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvm1jrhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 13:15:24 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138H2kUk020578;
        Thu, 8 Apr 2021 17:15:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 37rvc5gxt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 17:15:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138HFJoB28967292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 17:15:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29435AE061;
        Thu,  8 Apr 2021 17:15:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E76DEAE045;
        Thu,  8 Apr 2021 17:15:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.12])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 17:15:16 +0000 (GMT)
Message-ID: <a5f7f2b44e7d4de94b761324139024a31a1cf209.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] certs: Trigger creation of RSA module signing
 key if it's not an RSA key
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:15:15 -0400
In-Reply-To: <20210408152403.1189121-2-stefanb@linux.ibm.com>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
         <20210408152403.1189121-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AO1-tDlr5yiovy1p5SVqFnAZ6uvLSY7y
X-Proofpoint-ORIG-GUID: VLOP8Vy2_uXAVnfdz1r4VcgkAFE0dlY3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-08 at 11:24 -0400, Stefan Berger wrote:
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.
> 
> Trigger the creation of an RSA module signing key if it is not an RSA key.
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

