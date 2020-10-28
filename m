Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534929E198
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Oct 2020 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgJ1Vsy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Oct 2020 17:48:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32810 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbgJ1Vsp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SI1qPc083967;
        Wed, 28 Oct 2020 14:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dcrj4bwL6kRqoVuSb7fHKtc3sWUwGBMudZmWaqFZzkM=;
 b=jOmmznIwvIZpnGCjahVwU0jjTotgQVbIm9/yeoXKvwAe3Xa2avc0FTXBvlPnAs7cD6jy
 wr9zkXvunaF+U9q5kVQMB63Ab4tXFdVZpzLqbvWnm2z2jfPhxJrhZLLXlMTMqJ3ENIel
 Rqu8KwIzaRzIUSK/SGwe1UoK+2rNzzecgUErKvizbKNESVVGOFdOHdgr9sW7CCqsD4jj
 MNtI2opLAY9zwFFLmdcEdgjkli6mJmqV7ppiCYUyCRW0vQkYNgbaxALatc+4TwZdfLsK
 /wezCfJC0ABeu1XWZO7bFZO/Zyqh3jH0xiykPMUhjAbhRmO4t2IjtI5xjdItG8qFfoNL sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34f96ubr3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 14:21:29 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09SI2mkS095453;
        Wed, 28 Oct 2020 14:21:28 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34f96ubr2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 14:21:28 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SI20XB016190;
        Wed, 28 Oct 2020 18:21:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 34f9ep045e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 18:21:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09SILOlN31195558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 18:21:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8F5AAE045;
        Wed, 28 Oct 2020 18:21:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A24AE05A;
        Wed, 28 Oct 2020 18:21:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.112.250])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 18:21:22 +0000 (GMT)
Message-ID: <a0c4d8b6e8523ab245feb43492bf7f209d558c0e.camel@linux.ibm.com>
Subject: ima-evm-utils: version 1.3.2 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Wartan Hachaturow <wart@debian.org>
Date:   Wed, 28 Oct 2020 14:21:22 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_08:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=921
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ima-evm-utils v1.3.2 release adds docker based travis support for
testing different distro releases.  Please refer to the NEWS file for a
short summary and the git history for details.

thanks,

Mimi

