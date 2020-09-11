Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526D62664D7
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIKQq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 12:46:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgIKPIE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BF27Y6177662;
        Fri, 11 Sep 2020 11:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=78N6boiP7sSbNGznqK9poUrt9X7Jx1+BBrB8pMxTczE=;
 b=pNdvej3JrKE1JilpUaFBqYqF9cNuyjXLd3D33QvRkaRMEHR7PsLyz/zWwh00IVjg6ByI
 6oJ25BEAZ5JoHlk+QsRu26CtyfwaPZmPrgRhQEBuSWmqvubvJnQHc5BK462vudVzTVgq
 v0OUNDHobSHDm02SZxU42gA0cJo3Q9qz/OnmlrOW06wz0czTKWw78EWquylr4zBkCN/U
 6h2OdJRzR7DV7n+TNqaVt2GLt3gdw/nr+gwNMH8AEGNPzB3qjxyhlTJm7OWhws2KXIPZ
 VQgm2gxSIqhLSfY9wqjkcuTzhmMLGIG7WIO48eh2FQX62mjgllUz+rQbhzhdaxWQ5/g1 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gbdmrdyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:07:49 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BF2cJI180340;
        Fri, 11 Sep 2020 11:07:49 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gbdmrdy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:07:49 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BF2bhB028777;
        Fri, 11 Sep 2020 15:07:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gmt7n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:07:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BF7jr134931038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 15:07:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08D2B5204F;
        Fri, 11 Sep 2020 15:07:45 +0000 (GMT)
Received: from sig-9-65-251-51.ibm.com (unknown [9.65.251.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EAB5B52051;
        Fri, 11 Sep 2020 15:07:43 +0000 (GMT)
Message-ID: <d5cc5da578dfcf00adb3c344316677ff1099b591.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] ima: limit secure boot feedback scope for
 appraise
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Sep 2020 11:07:43 -0400
In-Reply-To: <20200905012020.7024-1-bmeneg@redhat.com>
References: <20200904194100.761848-4-bmeneg@redhat.com>
         <20200905012020.7024-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=3 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Fri, 2020-09-04 at 22:20 -0300, Bruno Meneguele wrote:
> Only prompt the unknown/invalid appraisal option if secureboot is enabled and
> if the current appraisal state is different from the original one.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks.  I tweaked this patch description and that of 4/4.  This patch
set is in next-integrity-testing.  Please take a look.

thanks,

Mimi

