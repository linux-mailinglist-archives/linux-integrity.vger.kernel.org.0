Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0E210B0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfEPWp5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 18:45:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbfEPWpx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 18:45:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GMbWgh010039
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 18:45:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shcgdhkvw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 18:45:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 May 2019 23:45:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 23:45:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GMjj6D54460446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 22:45:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B87FF4CBD6;
        Thu, 16 May 2019 22:45:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43BC4CBD3;
        Thu, 16 May 2019 22:45:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 May 2019 22:45:44 +0000 (GMT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of
 IMA Signature signer in IMA log
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
Date:   Thu, 16 May 2019 18:45:34 -0400
In-Reply-To: <715a9b39-0cde-1ce0-2d01-68d4fc0f5333@linux.microsoft.com>
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
         <1557854992.4139.69.camel@linux.ibm.com>
         <715a9b39-0cde-1ce0-2d01-68d4fc0f5333@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051622-0016-0000-0000-0000027C8816
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051622-0017-0000-0000-000032D9616B
Message-Id: <1558046734.4507.28.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-15 at 11:17 -0700, Lakshmi wrote:
> Hi Mimi,
> 
> I would like to make sure I understood your feedback.
> 
> > 
> > Why duplicate the certificate info on each record in the measurement
> > list?  Why not add the certificate info once, as the key is loaded
> > onto the .ima and .platform keyrings?
> > 
> 
> key_create_or_update function in security/keys/key.c is called to 
> add\update a key to a keyring. Are you suggesting that an IMA function 
> be called from here to add the certificate info to the IMA log?

There's an existing LSM hook in alloc_key(), but the keyring isn't
being passed.  Again a decision would need to be made as to whether
this needs to be an LSM or IMA hook.

> 
> Our requirement is that the key information is available in the IMA log 
> which is TPM backed.
> 

There's some confusion as to why adding the keys to the measurement
list is needed.  Could you respond to Ken's questions please?

Mimi

