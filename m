Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA5481C72
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Dec 2021 14:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhL3NaC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Dec 2021 08:30:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhL3NaB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Dec 2021 08:30:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BUDQBl3019216;
        Thu, 30 Dec 2021 13:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5wqcwPo+JZPoDs+nJ4na0pONcion1ETEAr0MjPw+iGY=;
 b=TVaoiEgPBXUnFDiG9uTentqk0CdbRm0N3xB87NO6WoOv79qvcrY1vSZCjKNNJhaF0jzd
 CHyYZQlR14T85bjVZpnKhIfiFEJ6X6PCa6D2M6fF1FQcRmnOZ4HrHq6m6DGv9BoDoxrw
 9jXlpRJpTHvc+8IrWOepZqFM0vaUrH1nD+yab4QmUXg52YX4hiYWGUfCjcVnFn6lXF3j
 M1rqFrmvDiSsiJE0MrjW1Nq7epMABfAPwAN93//O1AVw08+hLOl0DYm8/4BlUtPbalC7
 feVzxL8fqghj4IEvoZeoTNl1lAOdY+635+CfhMZXCpjYazKtWVDfmx7eOcuYyT75bRHD 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d9dn48120-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 13:29:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BUDTfNP025722;
        Thu, 30 Dec 2021 13:29:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d9dn4811q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 13:29:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BUDSPam027214;
        Thu, 30 Dec 2021 13:29:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3d5txb4rh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 13:29:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BUDTadf31916526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Dec 2021 13:29:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 617D75204F;
        Thu, 30 Dec 2021 13:29:36 +0000 (GMT)
Received: from sig-9-65-79-165.ibm.com (unknown [9.65.79.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5086D5204E;
        Thu, 30 Dec 2021 13:29:34 +0000 (GMT)
Message-ID: <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>, Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Date:   Thu, 30 Dec 2021 08:29:33 -0500
In-Reply-To: <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
References: <20211229215330.4134835-1-yaelt@google.com>
         <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: inuARKZRr4S3ita7VKwQ6fg_SLAj8hFM
X-Proofpoint-ORIG-GUID: ZhnyrrmrNrX89UukoyV91yqvP4mkA-TB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_03,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112300075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit,

On Thu, 2021-12-30 at 15:37 +0530, Sumit Garg wrote:
> + Jan, Ahmad
> 
> On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
> >
> > The encrypted.c class supports instantiation of encrypted keys with
> > either an already-encrypted key material, or by generating new key
> > material based on random numbers. This patch defines a new datablob
> > format: [<format>] <master-key name> <decrypted data length>
> > <decrypted data> that allows to instantiate encrypted keys using
> > user-provided decrypted data, and therefore allows to perform key
> > encryption from userspace. The decrypted key material will be
> > inaccessible from userspace.
> 
> This type of user-space key import feature has already been discussed
> at large in the context of trusted keys here [1]. So what makes it
> special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
> or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?
> 
> [1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de/
> 
> -Sumit
> 
> >
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yael Tiomkin <yaelt@google.com>

There is a difference between trusted and encrypted keys.  So in
addition to pointing to the rather long discussion thread, please
summarize the conclusion and, assuming you agree, include why in once
case it was acceptable and in the other it wasn't to provide userspace
key data.

thanks,

Mimi

