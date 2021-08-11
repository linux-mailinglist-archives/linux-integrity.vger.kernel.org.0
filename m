Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1366A3E96DA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhHKRcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 13:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25772 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhHKRcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 13:32:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BH3pUh165487;
        Wed, 11 Aug 2021 13:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mACfITnV8J3o63aXB09nu8+1Hc5tNSHHQ7PJEpKwvD8=;
 b=gsF/jItv/OXhkaN1J/qFcrrSvcIJ3BJn0xNIkcNpv2vsLjzO0kD+GiNqFTbIBMDvFtGY
 ZAio6J3a9C1NycI55FwzXJFqahz9RWEnfV/Bc5g8MRAdBy+TxnBboEFiZO99ux5P2hjX
 aPt/zcPy1FDxXC+SxO/5l5ePR6mrUEn7K5JlrxCCS84YTCgyFiClTKhEgr9RMoHu3SfW
 kLmeS8qmpU0essV/eqWbvANmXO7gIRGMzQcZ2tOlCkdYWG2VTAVa7f8QwYT9dbwO2Fab
 /AGY9HJVhoOwuCWiHNP2cs3/QQuH09x8V493p1a6Na1c0RCWxwFd2+fFf+WWARh2oboy xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abt97wrr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 13:31:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17BH4MVe175894;
        Wed, 11 Aug 2021 13:31:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abt97wrqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 13:31:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BHRJVl027088;
        Wed, 11 Aug 2021 17:31:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3a9ht90dke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 17:31:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BHSbRV58917280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 17:28:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EB39AE058;
        Wed, 11 Aug 2021 17:31:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CA9AAE053;
        Wed, 11 Aug 2021 17:31:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 17:31:50 +0000 (GMT)
Message-ID: <1e261f41462aac5e9fbb6d9397f5f86a5379a803.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     vt@altlinux.org, linux-integrity@vger.kernel.org
Date:   Wed, 11 Aug 2021 13:31:49 -0400
In-Reply-To: <YRP/+7XT25GbAEef@glitch>
References: <20210810202852.236354-1-bmeneg@redhat.com>
         <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
         <YRP/+7XT25GbAEef@glitch>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u7e7kTn7-FE-fzMqVWKkYatoufTkb5GT
X-Proofpoint-GUID: 34PJohOyLC2Lc0Gx7_Eczdkj6U4TAvlE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_06:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-11 at 13:51 -0300, Bruno Meneguele wrote:
> On Wed, Aug 11, 2021 at 10:52:00AM -0400, Mimi Zohar wrote:
> 
> > > 
> > > -	return pwd;
> > > +	return password;
> > 
> > Wouldn't a simpler fix be to test "pwd" here?
> >         if (!pwd)
> >                 free(password);
> >         return pwd;
> > 
> 
> The problem is on success, when 'pwd' is actually not NULL.
> With that, I can't free(password). I would need to asprintf(pwd, ...) or
> strndup(password). Because of that, I thought it would be cleaner to
> remove 'password' completely.

I see.  So instead of "return pwd" as suggested above,

        if (!pwd) {
                free(password);
                password = NULL;  <== set or return NULL
        }

        return password;

thanks,

Mimi

