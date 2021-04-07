Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1A3571E0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347346AbhDGQKp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 12:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354264AbhDGQK3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 12:10:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137G3sWC029259;
        Wed, 7 Apr 2021 12:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iyuIeRM9JjLviQuQ1jDmWzFfYJRvFJJlRmqg3El918E=;
 b=MC6jPpnpNfUVaCej0s53MckrWunS7gXqcwp831ocS6svhpKHVK5F4OqshkCidaXPEBcJ
 XaHy0fLQOBqtetBx422iAptp7GHrPFA3Wx7Ly4Ln6Jck9abfCQne/wt5TgL98R+z6MyN
 ExBfWM7ak2Y27HTwDP5WZvWSC6RP9TPAJNDdSvKCG+IdREE2naO5XDWRswoiBJXvaSNp
 fjTY5icQXQo7PDXL8gYXzoxj4W5BHSNjSpJyMF/RTSR/Gs0gvglh63CDelH6WVc0nTGq
 3FEQ0EfI+Yr3w43XQ2y2JnH6/bmxumCfc9qD17yQt79JI5b6rj8WdbBYAIuXo6/woPXe Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumx328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 12:10:13 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137G3sp9029186;
        Wed, 7 Apr 2021 12:10:13 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumx31c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 12:10:13 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137FqwES003725;
        Wed, 7 Apr 2021 16:10:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 37rvc5gf4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 16:10:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137GA7uZ40567056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 16:10:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D64B042056;
        Wed,  7 Apr 2021 16:10:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B03834204F;
        Wed,  7 Apr 2021 16:10:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.51.22])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 16:10:05 +0000 (GMT)
Message-ID: <5a217256a53f9c33aba4528ab0393b84c42b1813.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] Add support for ECDSA-signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 12:10:04 -0400
In-Reply-To: <YG3Ve9CR0zZE+tUu@kernel.org>
References: <20210406185340.1079403-1-stefanb@linux.ibm.com>
         <YG3Ve9CR0zZE+tUu@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GHNp2yJADpnwlPmy52pwiXdGXKRvpJ_W
X-Proofpoint-ORIG-GUID: gZWz4D_PUfW4i3oYORtowjjx2Pnu8Nrp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-04-07 at 18:53 +0300, Jarkko Sakkinen wrote:
> On Tue, Apr 06, 2021 at 02:53:38PM -0400, Stefan Berger wrote:
> > This series adds support for ECDSA-signed kernel modules.
> > 
> > The first patch in this series attempts to address the issue where a
> > developer created an ECDSA key for signing modules and then falls back
> > to compiling an older version of the kernel that does not support
> > ECDSA keys. In this case this patch would delete that ECDSA key if it is
> > in certs/signing_key.pem and trigger the creation of an RSA key. However,
> > for this to work this patch would have to be applied to previous versions
> > of the kernel but would also only work for the developer if he/she used a
> > stable version of the kernel to which this patch was applied. So whether
> > this patch actually achieves the wanted effect is not always guaranteed.
> 
> Just wondering why the key needs to be removed in the fallback.

The main concern is with bisecting the kernel.  Either elliptic curve
support or the first patch needs to be backported.  This patch will
cause the kernel module signing key to be regenerated.

Mimi

