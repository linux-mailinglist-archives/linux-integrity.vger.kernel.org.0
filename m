Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2762E27E0
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgLXPGs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 10:06:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbgLXPGs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 10:06:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BOF3Z65149766;
        Thu, 24 Dec 2020 10:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=q8YGhczbkcKXzgQaeIn/kNoKcZbJndYoAm57NZPdgWc=;
 b=QmqmF5y94Xlkp5ZSnUCKEhdnsWsLziPAO83jKYvflbU1gHd4vRNM4gVb38VYAkUDQY6n
 ZxKN4wXTY9pt2UtQoJbJDYzpfHVEkyNLrfBerovt46zNgTR48hyoTySK7pXvx4kGUH1l
 qeVB3dpe03QKiGDqM+iyBJPxyaHutVVt/mdHdS4ftNE/n2IrWSMIWKLzgGzhqrdLAx08
 iA6qfN/Wu7iJBDUDaWl+yoV2RTEhJCkKupGyiZgCYNsQazjB/INm4ZKaSmcc2kdZTX0j
 Zzd4LP4k5VTpa19DI680RB4ogFM+AmDxQGixTNfogQN8Nsc6kqlpRhyRLhGEXhcNCU6z Aw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mtf9ktdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 10:06:04 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BOF49r1004346;
        Thu, 24 Dec 2020 15:05:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 35k906tc50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 15:05:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BOF5uG725952676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 15:05:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10066AE04D;
        Thu, 24 Dec 2020 15:05:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 091CCAE045;
        Thu, 24 Dec 2020 15:05:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.132])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Dec 2020 15:05:54 +0000 (GMT)
Message-ID: <70db5b26ebb0d95eaab584e4877a300dc6d1829d.camel@linux.ibm.com>
Subject: Re: Security module stacking patches review
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@kernel.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 24 Dec 2020 10:05:53 -0500
In-Reply-To: <99c17a46-91ec-b934-333a-adb8c44e49da@schaufler-ca.com>
References: <99c17a46-91ec-b934-333a-adb8c44e49da.ref@schaufler-ca.com>
         <99c17a46-91ec-b934-333a-adb8c44e49da@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-24_08:2020-12-24,2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=973 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012240095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-12-16 at 09:49 -0800, Casey Schaufler wrote:
> I am going to be putting out another revision of the LSM stacking
> patch set just after 5.11-rc1. There are changes in the integrity
> sub-system that need your ACK before I can get the code upstream.
> Can I please get your review this time around?

Thank you for the reminder.  I'm hoping to look at this patch set
sometime next week.

Mimi

