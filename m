Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8378B26A889
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgIOPPH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 11:15:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbgIOPOw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 11:14:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FEAiCV052790;
        Tue, 15 Sep 2020 10:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0ZkMtvaol0O1zExLBnchm1pvMGJxGEuBOg21YBExhuw=;
 b=dD+9ZZKx97GUhIv1ofS4VUGkh7ZE2aM9CYF0T0VQ+5IEPsUzZYSf0N3eC9QOw1y/ix19
 NLKMqRrOjuyN++3jl51vkRm5vOI+NntC6IxKll0u/ADMJLhdLm44wV0Y/qJezFbYme9Q
 /ZYPfRg1Mgj6rglompcct95b4yI3Hk/EQWf7bYs5sFCY4KAz+blqoIun6FeX3l+dTeUo
 nO3sF8E/Zpz8ML+a7+yCil7af5Rdm0Zz7i2DI0/1z+N3fb7oGa6Qbui0zJAcB1lihvnX
 vrTO/YOwVRL7WVlQZb6TmOrRJaum2ELs1WxgijG/44SiPtX0ojo7oB2TTMM5OyUjzaUy Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jshrupad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 10:15:03 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FEB8rH055123;
        Tue, 15 Sep 2020 10:15:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jshrup8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 10:15:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FE8I99019472;
        Tue, 15 Sep 2020 14:15:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 33gny8bp08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 14:15:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FEEw4022348284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 14:14:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 145F6AE05D;
        Tue, 15 Sep 2020 14:14:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AC34AE061;
        Tue, 15 Sep 2020 14:14:56 +0000 (GMT)
Received: from sig-9-65-196-230.ibm.com (unknown [9.65.196.230])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 14:14:55 +0000 (GMT)
Message-ID: <91de933c58124113608d88e3bb289ec476b79701.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Use kmemdup rather than kmalloc+memcpy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Sep 2020 10:14:55 -0400
In-Reply-To: <20200909190907.164013-1-alex.dewar90@gmail.com>
References: <20200909190907.164013-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=749
 priorityscore=1501 suspectscore=3 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-09 at 20:09 +0100, Alex Dewar wrote:
> Issue identified with Coccinelle.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Thank you.

Mimi

