Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD886115
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 13:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHHLqR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 07:46:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHLqR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 07:46:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78BdZH8090159;
        Thu, 8 Aug 2019 11:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=lWre0LNF0/gz9O/mvQBUaRvu2IcBE4fusokHpyf4iwM=;
 b=UWqjz6l3ur8QABbV1slwmDqGrhg71nvY5OjmnDYaas/w37xN6smzu6w2QlLz4y6QQXC9
 1bUqO9dtU2NolzY8oGS46FO1EqmaPM4qKynseMziXGFXJ5TaPRxIVb7FzUkPDjOyAgPb
 De5Enjauco+PIPW+nDyYsjLJg7dGLabOTNXUPrxOELnylI/X5E5XOK16JanuUAr468bC
 F4whdVqxF83noduxc+6mfKcfxWvhnWfxTxJ2FOA1gFZu6sStnBisWNm16t3LvnLF7GSv
 a9p+G5d8481YTKYlBVzsPq41ZB6QtYj57eID5pApHrUyO04H4jF95fXQr8nxGyPaEEFo gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=lWre0LNF0/gz9O/mvQBUaRvu2IcBE4fusokHpyf4iwM=;
 b=tXar4+Eymg7Dr0WVTOjtihV2iNMzzQl7Rx9goWl2GdnIFB3XKzYRb/sUXtPZ9P246fuj
 NIM9kBTcpD3jQ9WRKPnuqt4WFciJG+HETFTFeopNA2R07OX6oJegi2e/Pmij0Gz5cupU
 lBQGP+PCOCZEKN5xjKSmnJ72MjDRTRv8KmszGenLYEByvNBmfARSLILaBbMuhqoCiw5C
 3jsCtNRsPxXfpdQXPUqxFVSZL7Ni75TuI7CElRhiGvfbkd2Uc1bHaKZrb9PB/SnKjEG5
 yK1k3zWT+35F4kIDndJ1tCVIEwafUrMY2NNgQPxz7CM5x/oQowHqj48txSdwCXMVjPoa Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u8hps0gy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 11:46:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78BjeUT033929;
        Thu, 8 Aug 2019 11:46:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2u763k7896-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 11:46:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x78BjvEX029685;
        Thu, 8 Aug 2019 11:45:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 04:45:57 -0700
Date:   Thu, 8 Aug 2019 14:45:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ima: Fix a use after free in ima_read_modsig()
Message-ID: <20190808114549.GJ1935@kadam>
References: <20190808103310.GC30506@mwanda>
 <1565263042.4220.25.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565263042.4220.25.camel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 08, 2019 at 07:17:22AM -0400, Mimi Zohar wrote:
> On Thu, 2019-08-08 at 13:33 +0300, Dan Carpenter wrote:
> > This code frees "hdr" and then dereferences it on the next line to get
> > the error code.
> > 
> > Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, Dan.  Julia already reported this.  Thiago posted a patch last
> night.  Just getting to it now.  Can I add your Reviewed-by or Tested-
> by?

I haven't seen the other patch so Reviewed-by seems like the wrong
thing.  I don't really need any sort of credit.  I'm just going through
my backlog of warnings from being out of office.  Perhaps Reported-by?

regards,
dan carpenter

