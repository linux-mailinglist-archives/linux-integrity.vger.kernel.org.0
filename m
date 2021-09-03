Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F366E40000A
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhICMzo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:55:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55326 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhICMzo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:55:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CXa3V117073
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b1xdZHiQqRvAy0Ovhw2RiCssm0sqOXQT8VqzggDEtu4=;
 b=fgKNrwaPmmAo+8dg1OjavIR+Lc5e1aucXXQ0WN7598kPFnBgdpXPeuDijn/MeURfO5Ym
 /FwNJ9GEp5BR+x/5hNneYqmP8tsjyr60UDsfcu4sJyBh9hG8ovqd4E42vjVGmtnPb283
 oOArshC1eYwgb3HwOOGX9jgaTLH1UvmLDBFYVEJ6epqoLp8TI2NFJ4GalNuteg01JmUO
 BfuGxr9oZpxMAMYimseAsQ/OdT49+jOB0U6n9FEm6qWD98fqpxxyqO/+zg4ZXWejKiGi
 G+jTDUjrByb6Qa/Xqe3DTrThvCl/0vm5V/u2twDqL9Mok7pJI/9441xmXiyKFCw4qiO6 2Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aukrrrhjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:54:43 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183CmC0U002595
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:54:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3au6q78f94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:54:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183CoWOb57278804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:50:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2FF952051;
        Fri,  3 Sep 2021 12:54:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD77552063;
        Fri,  3 Sep 2021 12:54:37 +0000 (GMT)
Message-ID: <add0f916068bf0df227426a87af6136480f015f8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/8] ima-evm-utils: Add support for signing with
 pkcs11 URIs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 08:54:36 -0400
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wZJtG1_4FuIW5yq-Fpuru6X_hMHYO96V
X-Proofpoint-ORIG-GUID: wZJtG1_4FuIW5yq-Fpuru6X_hMHYO96V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This series of patches adds support for signing with pkcs11 URIs and the
> keyid explicitly provided via a command line option.

Before explaining "what" , please provide the motivation for adding
pkcs11 support.

Other than updating the cover letter and the patch descriptions,
patches 1 - 6 look good.  (Still looking at 7/8 and 8/8.)

thanks,

Mimi

