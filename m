Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1E3FA136
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhH0Vid (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 17:38:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1162 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231696AbhH0Vid (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 17:38:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RLYm6p058541;
        Fri, 27 Aug 2021 17:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EAT9kwJ6JThpntsWy6H2ZaYoELwC/jOj1axfoNO67RY=;
 b=pnI6ClrXq4sPzeoksu7cw9avWw/cwr2N1lJKNcSq/nHKbongUuSF6qHTzmQGUh2tdaad
 bLVbnIgv4jzRKZbkGBdvB8IVg41dDrAWc2W/+SDar1j2aBgRVB20TJ6rC4rsg2AE7yaV
 BOBCWRiRc5pwzjVkoR2pSAsdoYMRkK3/Ns+FlbCEvgzP5dMy0BUHGqpWIQa4il5vkhEk
 2OPPq18NQSoa4zVn8T12AYLwkDdF4+XK1p/jXg4quFI7BsaYmYib8Rhb0Mad4Gly6feg
 sqv+WVD+gJM2W6Y0YrJhyp1vI4q/AjvHfHtATF4tEsjN+eDBYdUCavhMOb2mG1sRyJqX dQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aq75j918g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 17:37:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17RLXaVR011123;
        Fri, 27 Aug 2021 21:37:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrhmapq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 21:37:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17RLXnoU28639692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 21:33:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C233E4C044;
        Fri, 27 Aug 2021 21:37:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 898C04C040;
        Fri, 27 Aug 2021 21:37:36 +0000 (GMT)
Received: from sig-9-65-233-113.ibm.com (unknown [9.65.233.113])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Aug 2021 21:37:36 +0000 (GMT)
Message-ID: <8617ee0a7738ff2a5310efeca6d194339cf86560.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] evmctl: Implement support for
 EVMCTL_KEY_PASSWORD environment variable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 27 Aug 2021 17:37:35 -0400
In-Reply-To: <20210810134557.2444863-2-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-2-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2j9dMojfezRUU0_X297NCBzXGMdzKoj-
X-Proofpoint-ORIG-GUID: 2j9dMojfezRUU0_X297NCBzXGMdzKoj-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_06:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: Vitaly]

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> If the user did not use the --pass option to provide a key password,
> get the key password from the EVMCTL_KEY_PASSWORD environment variable.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.

Vitaly, I'm not sure that there's any benefit of using secure heap for
a password stored as an environment variable, but it needs to at least
be documented.

thanks,

Mimi

