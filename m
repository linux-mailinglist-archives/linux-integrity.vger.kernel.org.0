Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6B526195
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiEMMMl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiEMMMk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 08:12:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66263394
        for <linux-integrity@vger.kernel.org>; Fri, 13 May 2022 05:12:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DC0XJ5015924;
        Fri, 13 May 2022 12:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IXAlnsjagdkanynEy5KbfcBbS0A9QsV8TZKTQX72su8=;
 b=AR9M8QyI0RFl9YlnnIOnKAyIXTZFxSxsQkVczdy3qTqOfryJ1bar2E/NF1HXgN2djFN1
 MkI4EJC0YMsjkW6wFDqi9i23b3LriP50u9SZOmlhbFzUZOLS14L9VBvP7SC8vRyGDrGi
 LjW/9y4+63/HhaGuq6A39FU57C0jQzN5W3/Dg2r/XJKM2CZXuz8d1aKqDDz19uz+EAp0
 mSpTcGns/Q7/tXVcVvjZ807qwIwQMHziIBUb9rFEaZ6ovgIpbyYmJGx9wDrltRvDLB1S
 d/oo6euvEAcqCefVO/r2kLCBPxvvdZQ4b2iHB7VMrIv4SfN+5aaGvaczj2oJWrZrLNvT 4w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1py7g88w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:12:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DC1VAK026065;
        Fri, 13 May 2022 12:12:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g0kn7a487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:12:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DCCP1l50332136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 12:12:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34CFAAE04D;
        Fri, 13 May 2022 12:12:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB415AE045;
        Fri, 13 May 2022 12:12:24 +0000 (GMT)
Received: from sig-9-65-91-25.ibm.com (unknown [9.65.91.25])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 12:12:24 +0000 (GMT)
Message-ID: <17a2963c7f4151de9360912da494c924fbf2709d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 2/3] Sign an fs-verity file digest
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
Date:   Fri, 13 May 2022 08:12:24 -0400
In-Reply-To: <b4ed4a2c-2da2-b9f0-cb1c-50ee7ec43eba@linux.ibm.com>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
         <20220512183056.307597-2-zohar@linux.ibm.com>
         <b4ed4a2c-2da2-b9f0-cb1c-50ee7ec43eba@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OP-K93XL2zPBB-cSM3B9Ox--xQtDq3Rd
X-Proofpoint-GUID: OP-K93XL2zPBB-cSM3B9Ox--xQtDq3Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-12 at 17:48 -0400, Stefan Berger wrote:
> > -             /* find the end of the hash */
> > -             token = strpbrk(line, ", \t");
> > -             hashlen = token ? token - line : strlen(line);
> > +             /*
> > +              * Before either directly or indirectly signing the hash,
> > +              * convert the hex-ascii hash representation to binary.
> > +              */
> > +             if (veritysig) {
> > +
> > +                     /* split the algorithm from the hash */
> > +                     hashp = strpbrk(line, ":");
> > +                     if (!hashp) {   /* pointer to the delimiter */
> > +                             log_err("Missing fsverity hash algorithm\n");
> > +                             continue;
> > +                     }
> > +
> > +                     algolen = hashp - line;
> > +                     if (algolen > sizeof(algo))
> > +                             algolen = sizeof(algo);
> 
> I think a hash name exceeding the max buffer size and needing to be 
> truncating it should be an error since the name to index conversion will 
> fail  later on.

Sure.  In fact, the hash algorithm name size should be limited to the
maximum size of those algorithms that fs-verity actually supports.

thanks,

Mimi

