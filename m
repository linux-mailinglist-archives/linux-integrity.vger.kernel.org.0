Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2E40000F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbhICM47 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:56:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56435 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235211AbhICM46 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:56:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CXWVt083473
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=E2m64q4JQ3VUmjtViADc+6txEoTe8led9aQcdBezy6Q=;
 b=L9NLSt+HbE40BasLiR2tKtShd4eWIeqxRWgZg1bopRgdYz+zIPf3GGI7fcuSt/+eRyoL
 oMAPvjk2atpZ3dRyoGKXCkYp250fMG7i32zYWns12RsnaiVzXmGf3aC3thTSuwMDALaT
 WTPNCq1kWl7OXJO7HmlPmD6fH94yL5wzcsX7X1+AbX54vzf8YRdF3nonzNgxqwOrk5Bl
 mLfypLinZZpjqyNNnIBRCr9q0VuFLoJI1vkFZIdFsA/pPgYhNuNNvxvagI5hhNRN2tSa
 qQOjCvSL0881z9bru0zRRiX8gYAEzgfYhG1iwiP/mE8H9n8mtnkgr1yuYjRMgYSTv1HO xA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aukry8hnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:55:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183CmATZ002579
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:55:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3au6q78fn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:55:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183Ctr4O54002014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:55:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 090524204D;
        Fri,  3 Sep 2021 12:55:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6235F42045;
        Fri,  3 Sep 2021 12:55:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 12:55:52 +0000 (GMT)
Message-ID: <89a1668079bce662497f6cdad64cc6f7ce6c6790.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/8] evmctl: Setup the pkcs11 engine if key has
 pkcs11: prefix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 08:55:51 -0400
In-Reply-To: <20210810134557.2444863-6-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-6-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lgSSLGuv_eEOtCI6mee5uCPnbp7L80ns
X-Proofpoint-ORIG-GUID: lgSSLGuv_eEOtCI6mee5uCPnbp7L80ns
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Simplify the subject line.  Perhaps something like,  "evmctl: use the
pkcs11 engine for pkcs11 prefixed URIs"?

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> If the key has the pkcs11: URI prefix then setup the pkcs11 engine
> if the user hasn't chosen a specific engine already.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

thanks

Mimi

