Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35131A28D
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBLQW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 11:22:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41512 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBLQWz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 11:22:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CGDCQT070540;
        Fri, 12 Feb 2021 11:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IxZi1jlooPM1mZGtCgV6RKOuVs61eofHpgJ3JA4VbCE=;
 b=in13XMjjLOK+dqlGSqUd/zOAaKFhgh3itA96NlVi3IK3UCKP1s5NBylhEbSY/BrIpwQ8
 AmSJgZAXOEs4K8IMRN83CFpbeQ5HjFr8cGbxPhYEXZh8Lzer1vlNly1tIWfaZ/AdSNHq
 CFQgIFwVxuze9WGKgJqHLPYLItPG76p0h+LnA5baiRdIfO/fixFR9pI07GPzkSBOO+9v
 jzpd1vPcDOe1XADr+oafVJlASw+3QGDjvKhLOPKgTgsl3jNOsrAU95EVA6KL7ZZXCEro
 Vj5PB7fvDdYrHaQ+Cf+Ft2OTqI4dgIFP85cHAh5W9GCq3QQjIzv28Pn1cKXCzzEItIV+ aw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nw0mr6gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 11:21:50 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CG7AiK031012;
        Fri, 12 Feb 2021 16:21:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 36m1m2u135-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 16:21:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CGLkbA48824662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 16:21:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DC5842042;
        Fri, 12 Feb 2021 16:21:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0964842045;
        Fri, 12 Feb 2021 16:21:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.53.37])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 16:21:43 +0000 (GMT)
Message-ID: <90e088c262517a608324d523b67fef1ef007370f.camel@linux.ibm.com>
Subject: Re: [PATCH -next] integrity: Make function integrity_add_key()
 static
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Fri, 12 Feb 2021 11:21:43 -0500
In-Reply-To: <20210210080131.1209889-1-weiyongjun1@huawei.com>
References: <20210210080131.1209889-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_05:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=820 spamscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102120121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: linux-integrity]

On Wed, 2021-02-10 at 08:01 +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> security/integrity/digsig.c:146:12: warning:
>  symbol 'integrity_add_key' was not declared. Should it be static?
> 
> This function is not used outside of digsig.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks!   The patch is now queued.
  
Mimi

