Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D592E04B7
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2019 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfJVNSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 09:18:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49324 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfJVNSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 09:18:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MDEsYH173168;
        Tue, 22 Oct 2019 13:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=gvXlJJdZoi0UOi7sjSMdMEagvITjG6PigcIYf2Q3xM8=;
 b=GDj+TGGH4Hju+qltMrXe0xzygIP2O3KL4zbPBMbv1cqzjJGSKDDkT3jwGLiT8Lgh1/ay
 Oj/Fx0ag+T4dTaxit8Z1LDIS3A3jIXmRQsEglJt1M6fwNaWzUhl9x/EpOR5mXrLEGIyq
 ZeZj+dKOR+Kz6E9jwBOYZ585caqzLBb8hXWab4V5GA1WPhkFStBhdWM1QLyEUObZGHTl
 oWoXGMA9gTPaETE3YpPEgNuZmsMs1DkUzwh3QARvkGtErLt/SWt1UuxumUqarN9laBFq
 QXPiXjjj+6elzq+9ckddEX62z3uiQEFtYkw89NvsCidrI//uhAzezbiK/RDISnhG7X/+ vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqteppjdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 13:18:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MDEpUd078918;
        Tue, 22 Oct 2019 13:15:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vrc01v12r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 13:15:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9MDFvrq032236;
        Tue, 22 Oct 2019 13:15:57 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 06:15:57 -0700
Date:   Tue, 22 Oct 2019 16:15:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     tadeusz.struk@intel.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [bug report] tpm: add support for nonblocking operation
Message-ID: <20191022131550.GA4249@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=995 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Tadeusz Struk,

The patch 9e1b74a63f77: "tpm: add support for nonblocking operation"
from Sep 10, 2018, leads to the following static checker warning:

	drivers/char/tpm/tpm-dev-common.c:222 tpm_common_write()
	warn: inconsistent returns 'priv->chip->tpm_mutex'.

drivers/char/tpm/tpm-dev-common.c
   184  
   185          /* atomic tpm command send and result receive. We only hold the ops
   186           * lock during this period so that the tpm can be unregistered even if
   187           * the char dev is held open.
   188           */
   189          if (tpm_try_get_ops(priv->chip)) {
   190                  ret = -EPIPE;
   191                  goto out;
   192          }
   193  
   194          priv->response_length = 0;
   195          priv->response_read = false;
   196          *off = 0;
   197  
   198          /*
   199           * If in nonblocking mode schedule an async job to send
   200           * the command return the size.
   201           * In case of error the err code will be returned in
   202           * the subsequent read call.
   203           */
   204          if (file->f_flags & O_NONBLOCK) {
   205                  priv->command_enqueued = true;
   206                  queue_work(tpm_dev_wq, &priv->async_work);
   207                  mutex_unlock(&priv->buffer_mutex);
   208                  return size;
                        ^^^^^^^^^^^
Don't we need to do a tpm_put_ops(priv->chip) before returning?

   209          }
   210  
   211          ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
   212                                 sizeof(priv->data_buffer));
   213          tpm_put_ops(priv->chip);
   214  
   215          if (ret > 0) {
   216                  priv->response_length = ret;
   217                  mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
   218                  ret = size;
   219          }
   220  out:
   221          mutex_unlock(&priv->buffer_mutex);
   222          return ret;
   223  }

regards,
dan carpenter
