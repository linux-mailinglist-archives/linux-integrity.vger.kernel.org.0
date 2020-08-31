Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808A52581BB
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 21:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHaT1F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 15:27:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728985AbgHaT1D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 15:27:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VJCurj096905;
        Mon, 31 Aug 2020 15:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KL1absOS8yi5jocjv1yBRJ+JMgl+fEKwPeZiznWVnCg=;
 b=X/w+K7uHUcHOrLcuw7plfVcVTeTMQ0d82wuQt/5EGkuZ81C0qDSBUwAP6rJMOI35CmEP
 djCbFVws6PKaZQgUNOtTjrOdEOzeche8o8LBQbFvQrrMu/udtFlcoLhSraHAgbNoCCPs
 Xk1eZAfMW1d6lQvkHBWiyFufPJ8cNk2DudjDbVrES/tSJVrh+vhYLflJFCOqOwcVVEpi
 vWT2tqOwcbiAzp7kkFyw+Qaz+eF7tNq/FGCNmwxzZAI0wwmR+BT23bMYbobnbaMLKhTp
 QFGwsuzTvliJUMF5583SkrSoLL/ZI8orfq2yGQxS/itgRhmtb6f9eNPy33nj3QkZ+fgV Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33975w889d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 15:26:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VJDxkL098988;
        Mon, 31 Aug 2020 15:26:59 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33975w888t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 15:26:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VJC5Km001970;
        Mon, 31 Aug 2020 19:26:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 337en7hgv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 19:26:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07VJQsK822413624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 19:26:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B55FEA4055;
        Mon, 31 Aug 2020 19:26:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31DB5A4040;
        Mon, 31 Aug 2020 19:26:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Aug 2020 19:26:52 +0000 (GMT)
Message-ID: <3048ecb50bba7819ac9c40d3ff2f1ed60585bc48.camel@linux.ibm.com>
Subject: Re: [PATCH 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Mon, 31 Aug 2020 15:26:52 -0400
In-Reply-To: <a4bf0f73e0854cf18d942330a7543d9d@huawei.com>
References: <20200618160133.937-1-roberto.sassu@huawei.com>
         <20200618160133.937-2-roberto.sassu@huawei.com>
         <8a1773d7707639d275fff138736d57472e26ade5.camel@linux.ibm.com>
         <a4bf0f73e0854cf18d942330a7543d9d@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_09:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008310110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-31 at 09:44 +0000, Roberto Sassu wrote:
> 
> > As much as possible IMA and EVM should remain independent of each
> > other.   Modifying integrity_load_x509() doesn't help.  This looks like
> > a good reason for calling another EVM function from within IMA.
> 
> Can I add your Reviewed-by?

Yes, that's fine.

Mimi

