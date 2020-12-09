Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87CD2D4729
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbgLIQvf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 11:51:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727156AbgLIQvf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 11:51:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B9GWbLp073428;
        Wed, 9 Dec 2020 11:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Odsb8xyjIIIVuDCTk0SLDsR/3RdCoFAvh4mqCubQ+2A=;
 b=sou2VVe58bYe8S9Xkbe77OrgSXLpzFqyoHcV1WfYtP4zZZ0WjphhwqtJOy0oiQw7krQr
 EIWJzOIkE6p0zcdVpRRJjChuM5iWd+aMN4OJMCs3nBAXeW+SBwjx/l4HtdmDvusCJtQ+
 gdf0L3OhNN1SL3kFRCvDK4O+COOLYf6bN260MytuXNWezpa7FNTAdm6SiP4JF2R5NIux
 Xld2anv19DBl9Zbn6AaG01fSo1lyJEQoJspk6VR9zzlHakjbsWX/hH21fyn8BoBmelxW
 +6LkLmyoVapnZ39qMZP7JnERgLOAz5o39m69oBFF0n6C2tkfJOnlIdTQHbQqklG1UNeo kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35b1gxhm0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 11:50:31 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B9GWh8i074282;
        Wed, 9 Dec 2020 11:50:30 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35b1gxhkyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 11:50:30 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Gmomc002346;
        Wed, 9 Dec 2020 16:50:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8q49p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 16:50:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B9GoOJI47120874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 16:50:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2A744C046;
        Wed,  9 Dec 2020 16:50:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248254C044;
        Wed,  9 Dec 2020 16:50:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.48])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Dec 2020 16:50:19 +0000 (GMT)
Message-ID: <b2465d27f3683331019c5a9b6d0856304d992a0a.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, sumit.garg@linaro.org
Cc:     Elaine Palmer <erpalmerny@gmail.com>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Kenneth Goldman <kgoldman@us.ibm.com>, gcwilson@linux.ibm.com,
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>
Date:   Wed, 09 Dec 2020 11:50:19 -0500
In-Reply-To: <20201208174906.GA58572@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
         <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
         <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
         <20201204153037.GC4922@kernel.org>
         <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
         <20201208174906.GA58572@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_13:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-08 at 19:49 +0200, Jarkko Sakkinen wrote:
> On Tue, Dec 08, 2020 at 10:02:57AM -0500, Mimi Zohar wrote:

> > > Please also use a proper email client and split your paragraphs into
> > > at most 80 character lines with new line characters when writing email.
> > > I prefer to use 72 character line length so that there's some space
> > > for longer email threads.
> > 
> > Sure, we'll re-post the suggested documentation changes/additions.
> > 
> > Mimi
> 
> So. Wouldn't it be a better idea to post a patch that Sumit could
> squash to his (and add co-developed-by tag)?

I just posted it on Elaine's behalf.
  
Mimi

