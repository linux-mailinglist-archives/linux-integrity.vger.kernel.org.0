Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC13CB909
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhGPOtH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 10:49:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240377AbhGPOtH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 10:49:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GEYMpj012565;
        Fri, 16 Jul 2021 10:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sI6GdtEIT3row5WBsxRSaEpDpTnqyxXpifkEjOL5uEY=;
 b=F6Zo39DuVZ8W+uyBzBhFcoja5WbY5oktNL48Oe/25MCOpmK/AXE8vIQM+KW2qViKLNf6
 V283ioKaZRsj0xboft9+S42Oeoy2P6uxS4lpheaWxnEey2QvInTZVtpX/hyUbPYeGIrw
 x9TvVOIRrAtHiNLCq6MQiQyNlIUEa2i1uZCFCOIEhD47ifsQQ2sxcPVac94+Dam2fY34
 8lnpaxEgoaSVCUscOrAhdXfp0EbrBcD0P7+TlBff27CZFfZzClBmkRMbJeeKEcHWXUYl
 cNyGbkPnEeY1hWXntjAEsfqrUvOKbZGCQTCwr8SZcbZeT3EJz/o8H6gqQ0WZ7MrtWrMC Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tw2ryp3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 10:46:10 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16GEYu0L014877;
        Fri, 16 Jul 2021 10:46:10 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tw2ryp2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 10:46:09 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GEhiXN009869;
        Fri, 16 Jul 2021 14:46:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 39q3689fxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 14:46:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GEhr2Z21430618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 14:43:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 990185204E;
        Fri, 16 Jul 2021 14:46:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A0EEA52052;
        Fri, 16 Jul 2021 14:46:04 +0000 (GMT)
Message-ID: <f7cecf4bb48a0d825fe8f0c4dacf4a606dadc1a0.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 16 Jul 2021 10:46:03 -0400
In-Reply-To: <20210716135030.tc3fe3rmjmci2e4x@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
         <20210712054448.2471236-4-vt@altlinux.org>
         <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
         <20210716135030.tc3fe3rmjmci2e4x@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Ks7i3VcYMDDlcKpx9wry5afT5mw9qCT
X-Proofpoint-ORIG-GUID: nmhlvXbRAwDj4kdGM7T8StLohS4OB4NB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107160088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-07-16 at 16:50 +0300, Vitaly Chikunov wrote:
> > - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> > - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> > -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> > rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> > Using configuration from test-ca.conf
> > Error Loading extension section skid   <===
> 
> How `test-ca.conf' looked like? Maybe it's not updated?
> Try to run ./gen-keys.sh clean (which is called from make distclean).

Thanks, that resolved it.  Manually removing the keys wasn't enough.

Mimi

