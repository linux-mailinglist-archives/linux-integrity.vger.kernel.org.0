Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B42228422
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgGUPsD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 11:48:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbgGUPsD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 11:48:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LFVBf5167984;
        Tue, 21 Jul 2020 11:47:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vgk6q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:47:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LFechK020100;
        Tue, 21 Jul 2020 15:47:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq84278-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 15:47:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LFltV450331880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:47:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89A3BAE045;
        Tue, 21 Jul 2020 15:47:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2FA0AE051;
        Tue, 21 Jul 2020 15:47:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 15:47:54 +0000 (GMT)
Message-ID: <1595346474.5109.37.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 21 Jul 2020 11:47:54 -0400
In-Reply-To: <1595344015.4494.9.camel@HansenPartnership.com>
References: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
         <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
         <1595334627.5109.23.camel@linux.ibm.com>
         <1595344015.4494.9.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_09:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-21 at 08:06 -0700, James Bottomley wrote:
> On Tue, 2020-07-21 at 08:30 -0400, Mimi Zohar wrote:

> I think the sysfs output should be a pure hash to save having to
> massage it.  However, if you want the 1.2 format, this is the script I
> use:
> 
> a=0; while [ $a -lt 24 ]; do printf "PCR-%02d: " $a; cat
> /sys/class/tpm/tpm0/pcr-sha1/$a; a=$[$a+1]; done

The TPM 1.2 format is a bit different, but this provides the PCRs and
digests sequentially.

thanks,

Mimi
